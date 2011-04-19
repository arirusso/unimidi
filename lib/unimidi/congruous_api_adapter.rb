module UniMIDI

  module CongruousApiAdapter

    module Device
      
      def initialize(device_obj)
        @device = device_obj
      end
      
      def method_missing(method, *args, &block)
        @device.send(method, *args, &block)
      end
      
      def self.included(base)
        base.send(:attr_reader, :device)
      end

      module ClassMethods
        def device_class
          const_get("DeviceClass")
        end

        def method_missing(method, *args, &block)
          device_class.send(method, *args, &block)
        end

      end

    end

  end

end