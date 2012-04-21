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
      @logger = Bosh::Clouds::Config.logger
      @agent_properties = options["agent"]

      @ecloud_properties = @options["ecloud"]
      @vdc_properties = @ecloud_properties.delete("vdc")

      @client =  Fog::Compute.new({ :provider => 'Ecloud' }.merge(@ecloud_properties)})
    end

    def create_stemcell(image, _)
      raise Bosh::Clouds::NotImplemented.new("ECloudCloud::Cloud#create_stemcell")
    end

    def delete_stemcell(stemcell)
      raise Bosh::Clouds::NotImplemented.new("ECloudCloud::Cloud#delete_stemcell")
    end

    def create_vm(agent_id, stemcell, resource_pool, networks, disk_locality = nil, environment = nil)
      raise Bosh::Clouds::NotImplemented.new("ECloudCloud::Cloud#create_stemcell")
    end

    def delete_vm(vm_cid)
      raise Bosh::Clouds::NotImplemented.new("ECloudCloud::Cloud#create_stemcell")
    end

    def reboot_vm(vm_cid)
      raise Bosh::Clouds::NotImplemented.new("ECloudCloud::Cloud#create_stemcell")
    end

    def configure_networks(vm_cid, networks)
      raise Bosh::Clouds::NotImplemented.new("ECloudCloud::Cloud#create_stemcell")
    end

    def attach_disk(vm_cid, disk_cid)
      raise Bosh::Clouds::NotImplemented.new("ECloudCloud::Cloud#create_stemcell")
    end

    def detach_disk(vm_cid, disk_cid)
      raise Bosh::Clouds::NotImplemented.new("ECloudCloud::Cloud#create_stemcell")
    end

    def create_disk(size, _ = nil)
      raise Bosh::Clouds::NotImplemented.new("ECloudCloud::Cloud#create_stemcell")
    end

    def delete_disk(disk_cid)
      raise Bosh::Clouds::NotImplemented.new("ECloudCloud::Cloud#create_stemcell")
    end

    protected
    def generate_unique_name
      UUIDTools::UUID.random_create.to_s
    end

  end
end
