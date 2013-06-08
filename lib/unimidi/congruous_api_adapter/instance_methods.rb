module UniMIDI

  module CongruousApiAdapter

    # Methods that are shared by input and output devices
    module InstanceMethods

      def self.included(base)
        base.send(:attr_reader, :name)
        base.send(:attr_reader, :id)
        base.send(:attr_reader, :type)
        base.send(:alias_method, :direction, :type)
      end

      # @param [Object] device_obj The underlying device object to delegate functionality to.
      def initialize(device_obj)        
        @device = device_obj
        @id = @device.id
        @name = @device.name
        populate_type
      end

      # Has this device been enabled?
      # @return [Boolean] Whether the device has been enabled.
      def enabled?
        @device.enabled
      end

      # Enable the device for use.
      # @yield [UniMIDI::CongruousApiAdapter::Device] After enabling run the block
      # @yieldparam [UniMIDI::CongruousApiAdapter::Device] device Passes self to the block
      # @return [UniMIDI::CongruousApiAdapter::Device] Returns self.
      def open(*a, &block)
        @device.open(*a) unless enabled?
        if block_given?
          begin
            yield(self)
          ensure
            close
          end
        else
          at_exit do
            close
          end
          self
        end
        self
      end

      # Display name for the device.
      # @return [String] The display name for the device.
      def pretty_name
        "#{id}) #{name}"
      end

      # Close the device.
      # @return [Boolean] Whether the device successfully closed.
      def close(*a)
        @device.close(*a)
        true
      end

      private

      # Assigns a type identifier (eg :input, :output) for this device
      def populate_type
        @type = case @device.type
                when :source, :input then :input
                when :destination, :output then :output
                end
      end

    end

  end

end
