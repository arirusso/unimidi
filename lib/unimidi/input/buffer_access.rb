# frozen_string_literal: true

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

      # Gets any messages in the buffer in the same format as Input::StreamReader#gets. This doesn't remove
      # the messages from the buffer or have any effect on the StreamReader pointer position
      # @param [*Object] args
      # @return [Array<Hash>]
      def gets_buffer(*_args)
        @device.buffer
      end

      # Gets any messages in the buffer in the same format as Input#gets_s. This doesn't remove
      # the messages from the buffer or have any effect on the StreamReader pointer position
      # @param [*Object] args
      # @return [Array<Hash>]
      def gets_buffer_s(*_args)
        @device.buffer.map do |msg|
          msg[:data] = TypeConversion.numeric_byte_array_to_hex_string(msg[:data])
          msg
        end
      end

      # Gets any messages in the buffer in the same format as Input#gets_data. . This doesn't remove
      # the messages from the buffer or have any effect on the StreamReader pointer position
      # @param [*Object] args
      # @return [Array<Integer>]
      def gets_buffer_data(*_args)
        @device.buffer.map { |msg| msg[:data] }
      end
    end
  end
end
