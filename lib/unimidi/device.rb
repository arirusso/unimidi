module UniMIDI

  # Common logic that is shared by both Input and Output devices
  module Device

    # Methods that are shared by both Input and Output classes
    module ClassMethods

      include Enumerable

      # Iterate over all devices of this direction (eg Input, Output)
      def each(&block)
        all.each { |device| yield(device) }
      end

      # Prints ids and names of each device to the console
      # @return [Array<String>]
      def list
        all.map do |device|
          name = device.pretty_name
          puts(name)
          name
        end
      end

      # Shortcut to select a device by its name
      # @param [String, Symbol] name
      # @return [Input, Output]
      def find_by_name(name)
        all.find { |device| name.to_s == device.name }
      end

      # Streamlined console prompt that asks the user to select a device
      # When their input is received, the device is selected and enabled
      def gets(&block)
        device = nil
        direction = get_direction
        puts ""
        puts "Select a MIDI #{direction}..."
        while device.nil?
          list
          print "> "
          selection = $stdin.gets.chomp
          if selection != ""
            selection = Integer(selection) rescue nil
            device = all.find { |d| d.id == selection } unless selection.nil?
          end
        end
        device.open(&block)
        device
      end

      # Select the first device and enable it
      # @return [Input, Output]
      def first(&block)
        use_device(all.first, &block)
      end

      # Select the last device and enable it
      # @return [Input, Output]
      def last(&block)
        use_device(all.last, &block)
      end

      # Select the device at the given index and enable it
      # @param [Integer] index
      # @return [Input, Output]
      def use(index, &block)
        index = case index
                when :first then 0
                when :last then all.count - 1
                else index
                end
        use_device(at(index), &block)
      end
      alias_method :open, :use

      # Select the device at the given index
      # @param [Integer] index
      # @return [Input, Output]
      def at(index)
        all[index]
      end
      alias_method :[], :at

      private

      # The direction of the device eg "input", "output"
      # @return [String]
      def get_direction
        name.split("::").last.downcase
      end

      # Enable the given device
      # @param [Input, Output] device
      # @return [Input, Output]
      def use_device(device, &block)
        if device.enabled?
          yield(device) if block_given?
        else
          device.open(&block)
        end
        device
      end

    end

    # Methods that are shared by both Input and Output instances
    module InstanceMethods

      # @param [AlsaRawMIDI::Input, AlsaRawMIDI::Output, CoreMIDI::Destination, CoreMIDI::Source, MIDIJRuby::Input, MIDIJRuby::Output, MIDIWinMM::Input, MIDIWinMM::Output] device
      def initialize(device)
        @device = device
        @enabled = false

        populate_from_device
      end

      # Enable the device for use
      # Params are passed to the underlying device object
      # Can be passed a block to which the device will be passed in as the yieldparam
      # @param [*Object] args
      # @return [Input, Output] self
      def open(*args, &block)
        unless @enabled
          @device.open(*args)
          @enabled = true
        end
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
        end
        self
      end

      # A human readable display name for this device
      # @return [String]
      def pretty_name
        "#{id}) #{name}"
      end

      # Close the device
      # Params are passed to the underlying device object
      # @param [*Object] args
      # @return [Boolean]
      def close(*args)
        if @enabled
          @device.close(*args)
          @enabled = false
          true
        else
          false
        end
      end

      # Returns true if the device is not enabled
      # @return [Boolean]
      def closed?
        !@enabled
      end

      # Add attributes for the device instance
      # :direction, :id, :name
      def self.included(base)
        base.send(:attr_reader, :direction)
        base.send(:attr_reader, :enabled)
        base.send(:attr_reader, :id)
        base.send(:attr_reader, :name)
        base.send(:alias_method, :enabled?, :enabled)
        base.send(:alias_method, :type, :direction)
      end

      private

      # Populate the direction attribute
      def populate_direction
        @direction = case @device.type
                when :source, :input then :input
                when :destination, :output then :output
                end
      end

      # Populate attributes from the underlying device object
      def populate_from_device
        @id = @device.id
        @name = @device.name
        populate_direction
      end

    end

  end

end
