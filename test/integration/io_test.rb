require "integration/helper"

class UniMIDI::IoTest < Minitest::Test

  # ** these tests assume that TestOutput is connected to TestInput
  context "UniMIDI" do

    setup do
      @input = TestHelper::Integration.devices[:input].open
      @output = TestHelper::Integration.devices[:output].open
    end

    teardown do
      @input.close
      @output.close
    end

    context "full IO" do

      context "using numeric bytes" do

        setup do
          @messages = TestHelper::Integration.numeric_messages
          @messages_arr = @messages.inject(&:+).flatten
          @received_arr = []
          @pointer = 0
        end

        should "do IO" do

          @messages.each do |message|
            p "sending: #{message}"

            @output.puts(message)
            sleep(1)
            received = @input.gets.map { |m| m[:data] }.flatten

            p "received: #{received}"

            assert_equal(@messages_arr.slice(@pointer, received.length), received)
            @pointer += received.length
            @received_arr += received
          end
          assert_equal(@messages_arr.length, @received_arr.length)
        end
      end

      context "using byte Strings" do

        setup do
          @messages = TestHelper::Integration.string_messages
          @messages_str = @messages.join
          @received_str = ""
          @pointer = 0
        end

        should "do IO" do

          @messages.each do |message|

            p "sending: #{message}"

            @output.puts(message)
            sleep(1)
            received = @input.gets_bytestr.map { |m| m[:data] }.flatten.join
            p "received: #{received}"

            assert_equal(@messages_str.slice(@pointer, received.length), received)
            @pointer += received.length
            @received_str += received
          end
          assert_equal(@messages_str, @received_str)

        end

      end

      context "using MIDIMessages" do

        setup do
          @messages = TestHelper::Integration.message_objects
          @messages_arr = @messages.map(&:to_bytes).flatten
          @received_arr = []
          @pointer = 0
        end

        should "do IO" do

          @messages.each do |message|

            p "sending: #{message}"

            @output.puts(message)
            sleep(1)
            received = @input.gets.map { |m| m[:data] }.flatten

            p "received: #{received}"

            assert_equal(@messages_arr.slice(@pointer, received.length), received)
            @pointer += received.length
            @received_arr += received
          end
          assert_equal(@messages_arr.length, @received_arr.length)

        end

      end

    end

  end

end
