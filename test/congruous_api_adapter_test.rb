require 'helper'

class UniMIDI::CongruousApiAdapterTest < UniMIDI::TestCase

  context "Adapter" do

    setup do
      TestDeviceHelper.setup
    end

    context "Device#type" do

      should "be an input" do
        input = TestDeviceHelper.devices[:input]
        assert_equal(:input, input.type)
      end

      should "be an output" do
        output = TestDeviceHelper.devices[:output]
        assert_equal(:output, output.type)  
      end

    end

    context "Device.count" do

      setup do
        @inputs = Input.all
      end

      should "count all of the inputs" do
        assert_equal @inputs.count, Input.count
      end

    end

    context "Device.find_by_name" do

      setup do
        index = rand(0..(Output.count-1))
        @output = Output.all[index]
      end

      should "select the correct input" do
        result = Output.find_by_name(@output.name)
        assert_equal @output, result
      end

    end

    context "Device.first" do

      setup do
        @output = Output.all.first
      end

      should "open the output" do
        @output.expects(:open)
        output = Output.first
        @output.unstub(:open)
      end

      should "return the correct output" do
        output = Output.first
        assert_equal @output, output
      end
    end

  end
end
