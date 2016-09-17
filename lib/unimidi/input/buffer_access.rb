module UniMIDI

  class Input

    module BufferAccess

      # The device buffer
      # @return [Array<Hash>]
      def buffer
        @device.buffer
      end

      # Clears the input buffer
      # @return [Array]
      def clear_buffer
        @device.buffer.clear
      end

      # Gets any messages in the buffer in the same format as Input#gets. This doesn't remove the messages from the
      # buffer or have any effect on
      # @param [*Object] args
      # @return [Array<Hash>]
      def gets_buffer(*args)
        @device.buffer
      end

      # Gets any messages in the buffer in the same format as Input#gets_s, without removing them from the buffer
      # @param [*Object] args
      # @return [Array<Hash>]
      def gets_buffer_s(*args)
        @device.buffer.map { |msg| msg[:data] = TypeConversion.numeric_byte_array_to_hex_string(msg[:data]); msg }
      end

      # Gets any messages in the buffer in the same format as Input#gets_data without removing them from the buffer
      # @param [*Object] args
      # @return [Array<Fixnum>]
      def gets_buffer_data(*args)
        @device.buffer.map { |msg| msg[:data] }
      end

    end

  end

end
