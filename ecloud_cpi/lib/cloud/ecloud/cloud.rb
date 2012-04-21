require "fog"

# Terremark's ECloud
module ECloudCloud

  class Cloud < Bosh::Cloud

    class TimeoutException < StandardError; end

    attr_accessor :client

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

      p @options
      @ecloud_properties = @options["ecloud"]
      @vdc_properties = @ecloud_properties.delete("vdc")

      @fog_connection = {
        :provider            => 'Ecloud',
        :ecloud_username     => @ecloud_properties["ecloud_username"],
        :ecloud_password     => @ecloud_properties["ecloud_password"],
        :ecloud_version      => @ecloud_properties["ecloud_version"],
        :ecloud_versions_uri => @ecloud_properties["ecloud_versions_uri"]
      }
      @client =  Fog::Compute.new(@fog_connection)
    end

    def create_stemcell(image, _)
      not_implemented("create_stemcell")
    end

    def delete_stemcell(stemcell)
      not_implemented("delete_stemcell")
    end

    def create_vm(agent_id, stemcell, resource_pool, networks, disk_locality = nil, environment = nil)
      not_implemented("create_stemcell")
    end

    def delete_vm(vm_cid)
      not_implemented("create_stemcell")
    end

    def reboot_vm(vm_cid)
      not_implemented("create_stemcell")
    end

    def configure_networks(vm_cid, networks)
      not_implemented("create_stemcell")
    end

    def attach_disk(vm_cid, disk_cid)
      not_implemented("create_stemcell")
    end

    def detach_disk(vm_cid, disk_cid)
      not_implemented("create_stemcell")
    end

    def create_disk(size, _ = nil)
      not_implemented("create_stemcell")
    end

    def delete_disk(disk_cid)
      not_implemented("create_stemcell")
    end

    def validate_deployment(old_manifest, new_manifest)
      not_implemented(:validate_deployment)
    end

    protected
    def generate_unique_name
      UUIDTools::UUID.random_create.to_s
    end

  end
end
