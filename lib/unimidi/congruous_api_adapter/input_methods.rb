module UniMIDI

  module CongruousApiAdapter

    module InputMethods

      module ClassMethods

        # All inputs
        def all
          UniMIDI::Device.all_by_type[:input]
        end

      end

      def self.included(base)
        base.send(:extend, ClassMethods)
        base.send(:extend, Forwardable)
        base.send(:def_delegators, :@device, :buffer)
      end

      #
      # An array of MIDI event hashes as such:
      #   [
      #     { :data => [144, 60, 100], :timestamp => 1024 },
      #     { :data => [128, 60, 100], :timestamp => 1100 },
      #     { :data => [144, 40, 120], :timestamp => 1200 }
      #   ]
      #
      # the data is an array of Numeric bytes
      # the timestamp is the number of millis since this input was enabled
      #
      def gets(*a)
        @device.gets(*a)
      rescue SystemExit, Interrupt
        exit
      end

      #
      # Similar to Input#gets but returns message data as string of hex digits as such:
      #   [
      #     { :data => "904060", :timestamp => 904 },
      #     { :data => "804060", :timestamp => 1150 },
      #     { :data => "90447F", :timestamp => 1300 }
      #   ]
      #
      def gets_s(*a)
        @device.gets_s(*a)
      rescue SystemExit, Interrupt
        exit
      end
      alias_method :gets_bytestr, :gets_s
      alias_method :gets_hex, :gets_s

      #
      # Similar to Input#gets but returns an array of data bytes such as
      #   [144, 60, 100, 128, 60, 100, 144, 40, 120]
      #
      def gets_data(*a)
        arr = gets
        arr.map { |msg| msg[:data] }.inject(:+)
      end

      # Similar to Input#gets but returns a string of data such as "90406080406090447F"
      def gets_data_s(*a)
        arr = gets_bytestr
        arr.map { |msg| msg[:data] }.join
      end
      alias_method :gets_data_bytestr, :gets_data_s
      alias_method :gets_data_hex, :gets_data_s

      # Clears the buffer
      def clear_buffer
        @device.buffer.clear
      end

      # Gets any messages in the buffer in the same format as CongruousApiInput#gets 
      def gets_buffer(*a)
        @device.buffer
      end

      # Gets any messages in the buffer in the same format as CongruousApiInput#gets_s
      def gets_buffer_s(*a)
        @device.buffer.map { |msg| msg[:data] = TypeConversion.numeric_byte_array_to_hex_string(msg[:data]); msg }
      end

      # Gets any messages in the buffer in the same format as CongruousApiInput#gets_data
      def gets_buffer_data(*a)
        @device.buffer.map { |msg| msg[:data] }
      end

    end

  end

end
