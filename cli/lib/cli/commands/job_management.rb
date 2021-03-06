# Copyright (c) 2009-2012 VMware, Inc.

module Bosh::Cli::Command
  class JobManagement < Base
    include Bosh::Cli::DeploymentHelper

    def start_job(*args)
      change_job_state(:start, *args)
    end

    def stop_job(*args)
      change_job_state(:stop, *args)
    end

    def restart_job(*args)
      change_job_state(:restart, *args)
    end

    def recreate_job(*args)
      change_job_state(:recreate, *args)
    end

    def change_job_state(operation, *args)
      auth_required
      manifest_yaml = prepare_deployment_manifest(:yaml => true)
      manifest = YAML.load(manifest_yaml)

      unless [:start, :stop, :restart, :recreate].include?(operation)
        err("Unknown operation `#{operation}': supported operations are " +
            "`start', `stop', `restart', `recreate'")
      end

      args  = args.dup
      hard  = args.delete("--hard")
      soft  = args.delete("--soft")
      force = args.delete("--force")

      if hard && soft
        err("Cannot handle both --hard and --soft options, please choose one")
      end

      if operation != :stop && (hard || soft)
        err("--hard and --soft options only make sense for `stop' operation")
      end

      job = args.shift
      index = args.shift
      deployment_desc = "`#{deployment.green}' to `#{target_name.green}'"
      job_desc = index ? "#{job}(#{index})" : "#{job}"

      case operation
      when :start
        op_desc = "start #{job_desc}"
        new_state = "started"
        completion_desc = "#{job_desc.green} has been started"
      when :stop
        if hard
          op_desc = "stop #{job_desc} and power off its VM(s)"
          completion_desc = "#{job_desc.green} has been stopped, " +
                            "VM(s) powered off"
          new_state = "detached"
        else
          op_desc = "stop #{job_desc}"
          completion_desc = "#{job_desc.green} has been stopped, " +
                            "VM(s) still running"
          new_state = "stopped"
        end
      when :restart
        op_desc = "restart #{job_desc}"
        new_state = "restart"
        completion_desc = "#{job_desc.green} has been restarted"
      when :recreate
        op_desc = "recreate #{job_desc}"
        new_state = "recreate"
        completion_desc = "#{job_desc.green} has been recreated"
      end

      say("You are about to #{op_desc.green}")

      if interactive?
        # TODO: refactor inspect_deployment_changes
        # to decouple changeset structure and rendering
        other_changes_present = inspect_deployment_changes(
            manifest, :show_empty_changeset => false)

        if other_changes_present && !force
          err("Cannot perform job management when other deployment changes " +
              "are present. Please use `--force' to override.")
        end
        unless confirmed?("#{op_desc.capitalize}?")
          cancel_deployment
        end
      end
      nl

      say("Performing `#{op_desc}'...")

      status, body = director.change_job_state(manifest["name"],
                                               manifest_yaml,
                                               job, index, new_state)

      responses = {
        :done => completion_desc,
        :non_trackable => "Started deployment but director at '#{target}' " +
                          "doesn't support deployment tracking",
        :track_timeout => "Started deployment but timed out out "+
                          "while tracking status",
        :error => "Started deployment but received an error " +
                  "while tracking status",
        :invalid => "Deployment is invalid, please fix it and deploy again"
      }

      say(responses[status] || "Cannot deploy: #{body}")
    end

  end
end
