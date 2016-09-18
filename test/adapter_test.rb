require "helper"

class UniMIDI::AdapterTest < Minitest::Test

  context "Adapter" do

    context "Device#type" do

      context "input" do

        setup do
          @input = TestHelper.mock_devices[:input].sample
        end

        should "be an input" do
          assert_equal(:input, @input.type)
        end

      end

      context "output" do

        setup do
          @output = TestHelper.mock_devices[:output].sample
        end

        should "be an output" do
          assert_equal(:output, @output.type)
        end

      end

    end

    context "Device.count" do

      setup do
        UniMIDI::Input.stubs(:all).returns(TestHelper.mock_devices[:input])
        @inputs = UniMIDI::Input.all
      end

      teardown do
        UniMIDI::Input.unstub(:all)
      end

      should "count all of the inputs" do
        assert_equal TestHelper.mock_devices[:input].count, UniMIDI::Input.count
      end

    end

    context "Device.find_by_name" do

      setup do
        index = rand(0..(UniMIDI::Output.count-1))
        @output = UniMIDI::Output.all[index]
      end

      should "select the correct input" do
        result = UniMIDI::Output.find_by_name(@output.name)
        assert_equal @output, result
      end

    end

    context "Device.first" do

      setup do
        @output = UniMIDI::Output.all.first
      end

      should "open the output" do
        @output.expects(:open)
        output = UniMIDI::Output.first
        @output.unstub(:open)
      end

      should "return the correct output" do
        output = UniMIDI::Output.first
        assert_equal @output, output
      end
    end

  end
end
