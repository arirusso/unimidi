# Modules
require "unimidi/congruous_api_adapter/device/cache"
require "unimidi/congruous_api_adapter/device/class_methods"
require "unimidi/congruous_api_adapter/device/dsl"
require "unimidi/congruous_api_adapter/device/instance_methods"

module UniMIDI

  module CongruousApiAdapter

    module Device

      # All devices
      def all
        all_by_type.values.flatten
      end

    end

  end

end
