module UniMIDI

  class Input

    module StreamReader

      # Plucks data from the input buffer and returns it as array of MIDI event hashes as such:
      #
      # The data is returned as array of MIDI event hashes as such:
      #   [
      #     { :data => [144, 60, 100], :timestamp => 1024 },
      #     { :data => [128, 60, 100], :timestamp => 1100 },
      #     { :data => [144, 40, 120], :timestamp => 1200 }
      #   ]
      #
      # In this case, the data is an array of Numeric bytes
      # The timestamp is the number of millis since this input was enabled
      # Arguments are passed to the underlying device object
      #
      # @param [*Object] args
      # @return [Array<Hash>]
      def gets(*args)
        @device.gets(*args)
      rescue SystemExit, Interrupt
        exit
      end

      #
      # Plucks data from the input buffer and returns it as array of MIDI event hashes.
      # Similar to Input#gets except that the returned message data as string of hex digits eg:
      #   [
      #     { :data => "904060", :timestamp => 904 },
      #     { :data => "804060", :timestamp => 1150 },
      #     { :data => "90447F", :timestamp => 1300 }
      #   ]
      #
      # @param [*Object] args
      # @return [Array<Hash>]
      def gets_s(*args)
        @device.gets_s(*args)
      rescue SystemExit, Interrupt
        exit
      end
      alias_method :gets_bytestr, :gets_s
      alias_method :gets_hex, :gets_s

      #
      # Plucks data from the input buffer and returns it as an array of data bytes such as
      #   [144, 60, 100, 128, 60, 100, 144, 40, 120]
      #
      # @param [*Object] args
      # @return [Array<Fixnum>]
      def gets_data(*args)
        arr = gets(*args)
        arr.map { |msg| msg[:data] }.inject(:+)
      end

      #
      # Plucks data from the input buffer and returns it as a string of data such as
      #   "90406080406090447F"
      #
      # @param [*Object] args
      # @return [String]
      def gets_data_s(*args)
        arr = gets_bytestr(*args)
        arr.map { |msg| msg[:data] }.join
      end
      alias_method :gets_data_bytestr, :gets_data_s
      alias_method :gets_data_hex, :gets_data_s

    end

  end

end
