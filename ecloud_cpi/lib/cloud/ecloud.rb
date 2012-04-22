# Terremark's ECloud

require "common/thread_pool"
require "common/thread_formatter"
require "uuidtools"

require "cloud"
require "cloud/ecloud/cloud"

autoload :ECloudCloud, "cloud/ecloud/cloud"

module Bosh
  module Clouds

    class ECloud
      extend Forwardable

      def_delegators :@delegate,
                     :create_stemcell, :delete_stemcell,
                     :create_vm, :delete_vm, :reboot_vm,
                     :configure_networks,
                     :create_disk, :delete_disk,
                     :attach_disk, :detach_disk,
                     :validate_deployment

      def initialize(options)
        @delegate = ECloudCloud::Cloud.new(options)
      end
    end

    Ecloud = ECloud # alias name
  end

end
