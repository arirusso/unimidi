module UniMIDI

  module CongruousApiAdapter

    module DeviceMethods

      # All devices
      def all
        all_by_type.values.flatten
      end

    end

  end

end
