module UniMIDI

  module CongruousApiAdapter

    module DSL

      def adapts(klass)
        DeviceCache.device_class = klass
      end

      def input_class(klass)
        DeviceCache.input_class = klass
      end

      def output_class(klass)
        DeviceCache.output_class = klass
      end

    end

  end

end
