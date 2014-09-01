module UniMIDI

  # Common logic that is shared by both Input and Output devices
  module Device

    # Methods that are shared by both Input and Output classes
    module ClassMethods

      include Enumerable

      # Iterate over all devices of this type
      def each(&block)
        all.each { |device| yield(device) }
      end

      # Prints ids and names of each device to the console
      def list
        all.map do |device| 
          name = device.pretty_name
          puts(name)
          name
        end
      end

      # Shortcut to get a device by its name
      def find_by_name(name)
        all.find { |device| name == device.name }
      end

      # streamlined console prompt that asks the user to select a device
      def gets(&block)
        device = nil
        class_name = self.name.split("::").last.downcase
        puts ""
        puts "Select a MIDI #{class_name}..."
        while device.nil?
          list
          print "> "
          selection = $stdin.gets.chomp
          if selection != ""
            selection = Integer(selection) rescue nil
            device = all.find { |d| d.id == selection }
          end
        end
        device.open(&block) unless device.enabled?
      end

      # returns the first device for this class
      def first(&block)
        use_device(all.first, &block)
      end

      # returns the last device for this class
      def last(&block)
        use_device(all.last, &block)
      end

      # returns the device at <em>index</em> and opens it
      def use(index, &block)
        index = case index
                when :first then 0
                when :last then all.size - 1
                else index
                end
        use_device(all[index], &block) 
      end
      alias_method :open, :use

      # returns the device at <em>index</em>
      def [](index)
        all[index]
      end

      private

      def use_device(device, &block)
        device.open(&block) unless device.enabled?
        device         
      end

    end

    # Methods that are shared by both Input and Output instances
    module InstanceMethods

      def initialize(device_obj)        
        @device = device_obj
        @id = @device.id
        @name = @device.name
        @enabled = false
        populate_type
      end

      def enabled?
        @enabled = true if @device.enabled # keep the adapter in sync
        @enabled
      end

      # enable the device for use, can be passed a block to which the device will be passed back
      def open(*a, &block)
        @device.open(*a) unless enabled?
        @enabled = true
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
      end

      def pretty_name
        "#{id}) #{name}"
      end

      # close the device
      def close(*a)
        @device.close(*a)
      end

      def self.included(base)
        base.send(:attr_reader, :name)
        base.send(:attr_reader, :id)
        base.send(:attr_reader, :type)
        base.send(:alias_method, :direction, :type)
      end

      private

      def populate_type
        @type = case @device.type
                when :source, :input then :input
                when :destination, :output then :output
                end
      end

    end

  end

end
