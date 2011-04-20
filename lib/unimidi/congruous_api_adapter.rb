module UniMIDI

  module CongruousApiAdapter

    module Device
      
      def initialize(device_obj)
        @device = device_obj
      end
      
      def method_missing(method, *args, &block)
        @device.respond_to?(method) ? @device.send(method, *args, &block) : super
      end
      
      def self.included(base)
        base.send(:attr_reader, :device)
      end

      module ClassMethods
        
        def device_class
          const_get("DeviceClass")
        end

        def method_missing(method, *args, &block)
          device_class.respond_to?(method) ? device_class.send(method, *args, &block) : super 
        end

      end

    end

  end

end