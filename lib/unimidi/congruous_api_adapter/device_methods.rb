module UniMIDI

  module CongruousApiAdapter

    # Class methods used by the outer device module adapter
    module DeviceMethods

      # An array of all devices
      def all
        all_by_type.values.flatten
      end

    end

  end

end
