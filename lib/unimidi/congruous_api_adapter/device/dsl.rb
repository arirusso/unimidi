module UniMIDI

  module CongruousApiAdapter

    module Device

      module DSL

        def adapts(klass)
          Cache.device_class = klass
        end

        def input_class(klass)
          Cache.input_class = klass
        end

        def output_class(klass)
          Cache.output_class = klass
        end

      end

    end

  end

end

