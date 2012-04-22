require "fog"

# Terremark's ECloud
module ECloudCloud

  class Cloud < Bosh::Cloud

    class TimeoutException < StandardError; end

    attr_reader :client
    attr_reader :vdc_properties

    ##
    # Initialize BOSH ECloud CPI
    # @param [Hash] options CPI options
    #
    # Example options (from a deployment manifest yaml file)
    # cloud:
    #   plugin: ecloud
    #   properties:
    #     ecloud:
    #       ecloud_username: EMAIL
    #       ecloud_password: PASSWORD
    #       ecloud_version: "0.8b-ext2.6"
    #       ecloud_versions_uri: "https://services.enterprisecloud.terremark.com/api/versions"
    #       vdc:
    #         href: 'https://services.enterprisecloud.terremark.com/api/v0.8b-ext2.6/vdc/999'
    def initialize(options)
      @options = options.dup
      @logger = Bosh::Clouds::Config.logger
      @agent_properties = @options["agent"]

      @fog_connection = {
        :provider            => 'Ecloud',
        :ecloud_username     => @options["ecloud"]["ecloud_username"],
        :ecloud_password     => @options["ecloud"]["ecloud_password"],
        :ecloud_version      => @options["ecloud"]["ecloud_version"],
        :ecloud_versions_uri => @options["ecloud"]["ecloud_versions_uri"]
      }
      @client =  Fog::Compute.new(@fog_connection)

      @vdc_properties = @options["ecloud"]["vdc"]
    end

    def create_stemcell(image, _)
      not_implemented("create_stemcell")
    end

    def delete_stemcell(stemcell)
      not_implemented("delete_stemcell")
    end

    def create_vm(agent_id, stemcell, resource_pool, networks, disk_locality = nil, environment = nil)
      not_implemented("create_vm")
    end

    def delete_vm(vm_cid)
      not_implemented("delete_vm")
    end

    def reboot_vm(vm_cid)
      not_implemented("reboot_vm")
    end

    def configure_networks(vm_cid, networks)
      not_implemented("configure_networks")
    end

    def attach_disk(vm_cid, disk_cid)
      not_implemented("attach_disk")
    end

    def detach_disk(vm_cid, disk_cid)
      not_implemented("detach_disk")
    end

    def create_disk(size, _ = nil)
      not_implemented("create_disk")
    end

    def delete_disk(disk_cid)
      not_implemented("delete_disk")
    end

    def validate_deployment(old_manifest, new_manifest)
      not_implemented("validate_deployment") # nor implemented in vsphere nor aws CPIs
    end

    protected
    def generate_unique_name
      UUIDTools::UUID.random_create.to_s
    end

  end
end
