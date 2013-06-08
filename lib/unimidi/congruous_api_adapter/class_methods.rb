module UniMIDI

  module CongruousApiAdapter

    module ClassMethods

      def self.extended(base)
        base.send(:extend, CongruousApiAdapter::DSL)
      end

      # Print ids and names of each device to the console
      def list
        all.each { |device| puts(device.pretty_name) }
      end

      # Print a streamlined console prompt that asks the user to select a device
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
        device.open(&block)
      end

      # The first device for this class
      def first(&block)
        use_device(all.first, &block)
      end

      # The last device for this class
      def last(&block)
        use_device(all.last, &block)
      end

      # Selects the device at the specified index and opens it
      def use(index, &block)
        index = case index
                when :first then 0
                when :last then all.size - 1
                else index
                end
        use_device(all[index], &block) 
      end
      alias_method :open, :use

      # Select the device at the specified index
      def [](index)
        all[index]
      end

      # All devices as a hash as such
      #   { :input => [input devices], :output => [output devices] }
      def all_by_type
        DeviceCache.ensure_initialized
        DeviceCache.devices
      end

      private

      def use_device(device, &block)
        device.open(&block)
        device         
      end

    end

  end

end
