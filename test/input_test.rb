require 'helper'

class UniMIDI::InputBufferTest < Test::Unit::TestCase

  context "Input" do

    context "#buffer" do

      setup do
        sleep(1)
        @input = TestHelper.devices[:input]
        @output = TestHelper.devices[:output]
        @messages = TestHelper.numeric_messages
        @bytes = []
      end

      should "add received messages to the buffer" do

        @input.buffer.clear

        @messages.each do |msg|

          p "sending: #{msg}"
          @output.puts(msg)
          @bytes += msg 
          sleep(0.5)
          buffer = @input.buffer.map { |m| m[:data] }.flatten
          p "received: #{buffer}"
          assert_equal(@bytes, buffer)

        end

        assert_equal(@bytes.length, @input.buffer.map { |m| m[:data] }.flatten.length)

      end

    end
  end
end
