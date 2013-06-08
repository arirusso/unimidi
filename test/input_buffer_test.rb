require 'helper'

class InputBufferTest < UniMIDI::TestCase

 def test_input_buffer
    sleep(1)

    messages = VariousMIDIMessages
    bytes = []

    $test_device[:output].open do |output|
      $test_device[:input].open do |input|
        
        input.buffer.clear

        messages.each do |msg|

          $>.puts "sending: " + msg.inspect

          output.puts(msg)
          
          bytes += msg 
          
          sleep(0.5)
          
          buffer = input.buffer.map { |m| m[:data] }.flatten

          $>.puts "received: " + buffer.to_s
          
          assert_equal(bytes, buffer)

        end
        
        assert_equal(bytes.length, input.buffer.map { |m| m[:data] }.flatten.length)

      end
    end
  end

end
