require 'helper'

class UniMIDI::InputBufferTest < UniMIDI::TestCase

  context "Input" do

    setup do
      TestDeviceHelper.setup
    end

    context "#buffer" do

      setup do
        sleep(1) 
        @messages = VariousMIDIMessages
        @bytes = []
      end

      should "add received messages to the buffer" do

        TestDeviceHelper.devices[:output].open do |output|
          TestDeviceHelper.devices[:input].open do |input|

            input.buffer.clear

            @messages.each do |msg|

              $>.puts "sending: " + msg.inspect
              output.puts(msg)
              @bytes += msg 
              sleep(0.5)
              buffer = input.buffer.map { |m| m[:data] }.flatten
              $>.puts "received: " + buffer.to_s
              assert_equal(@bytes, buffer)

            end

            assert_equal(@bytes.length, input.buffer.map { |m| m[:data] }.flatten.length)

          end
        end
      end

    end
  end
end
