require "integration/helper"

class UniMIDI::InputTest < Minitest::Test

  context "Input" do

    context "#buffer" do

      setup do
        sleep(1)
        @input = TestHelper::Integration.devices[:input].open
        @output = TestHelper::Integration.devices[:output].open
        @messages = TestHelper::Integration.numeric_messages
        @bytes = []
      end

      teardown do
        @input.close
        @output.close
      end

      should "add received messages to the buffer" do

        @input.buffer.clear

        @messages.each do |message|

          p "sending: #{message}"
          @output.puts(message)
          @bytes += message
          sleep(1)
          buffer = @input.buffer.map { |m| m[:data] }.flatten
          p "received: #{buffer}"
          assert_equal(@bytes, buffer)

        end

        assert_equal(@bytes.length, @input.buffer.map { |m| m[:data] }.flatten.length)

      end

    end
  end
end
