#!/usr/bin/env ruby

require 'helper'

class IoTest < Test::Unit::TestCase

  include UniMIDI
  include TestHelper
  include TestHelper::Config # before running these tests, adjust the constants in config.rb to suit your hardware setup

  # ** this test assumes that TestOutput is connected to TestInput
  def test_full_io

    messages = VariousMIDIMessages

    TestOutput.open do |output|
      TestInput.open do |input|

        messages.each do |msg|

          $>.puts "sending: " + msg.inspect

          output.puts(msg)

          received = input.gets.first[:data]

          $>.puts "received: " + received.inspect

          assert_equal(msg, received)
          
        end
        
        assert_equal(input.buffer.length, messages.length)

      end
    end
  end

  # ** this test assumes that TestOutput is connected to TestInput
  def test_full_io_bytestr
    sleep(1) # pause between tests

    messages = VariousMIDIByteStrMessages

    TestOutput.open do |output|
      TestInput.open do |input|

        messages.each do |msg|

          $>.puts "sending: " + msg.inspect

          output.puts(msg)

          received = input.gets_bytestr.first[:data]
          $>.puts "received: " + received.inspect

          assert_equal(msg, received)
          
        end
        
        assert_equal(input.buffer.length, messages.length)
      end
    end

  end

  # ** this test assumes that TestOutput is connected to TestInput
  def test_full_io_no_timestamps

    messages = VariousMIDIMessages

    TestOutput.open do |output|
      TestInput.open do |input|

        messages.each do |msg|

          $>.puts "sending: " + msg.inspect

          output.puts(msg)

          received = input.gets_data

          $>.puts "received: " + received.inspect

          assert_equal(msg, received)
          
        end
        
        assert_equal(input.buffer.length, messages.length)

      end      
      
    end
  end

  # ** this test assumes that TestOutput is connected to TestInput
  def test_full_io_bytestr_no_timestamps
    sleep(1) # pause between tests

    messages = VariousMIDIByteStrMessages

    TestOutput.open do |output|
      TestInput.open do |input|

        messages.each do |msg|

          $>.puts "sending: " + msg.inspect

          output.puts(msg)

          received = input.gets_data_bytestr
          $>.puts "received: " + received.inspect

          assert_equal(msg, received)
          
        end
        
        assert_equal(input.buffer.length, messages.length)
      end
      
    end

  end

end