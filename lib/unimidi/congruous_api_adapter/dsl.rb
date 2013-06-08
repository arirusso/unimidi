module UniMIDI

  module CongruousApiAdapter

    # DSL for adapter class definitions
    module DSL

      # Set the underlying device class that the adapter class addresses
      def adapts(klass)
        DeviceCache.device_class = klass
      end

      # Set the adapter input class
      def input_class(klass)
        DeviceCache.input_class = klass
      end

      # Set the adapter output class
      def output_class(klass)
        DeviceCache.output_class = klass
      end

    end

  end

end
