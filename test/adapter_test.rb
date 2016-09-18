require "helper"

class UniMIDI::AdapterTest < Minitest::Test

  context "Adapter" do

    setup do
      UniMIDI::Input.stubs(:all).returns(TestHelper.mock_devices[:input])
      UniMIDI::Output.stubs(:all).returns(TestHelper.mock_devices[:output])
    end

    teardown do
      UniMIDI::Input.unstub(:all)
      UniMIDI::Output.unstub(:all)
    end

    context "Device#type" do

      context "input" do

        setup do
          @input = UniMIDI::Input.all.sample
        end

        should "be an input" do
          assert_equal(:input, @input.type)
        end

      end

      context "output" do

        setup do
          UniMIDI::Input.stubs(:all).returns(TestHelper.mock_devices[:input])
          @output = UniMIDI::Output.all.sample
        end

        should "be an output" do
          assert_equal(:output, @output.type)
        end

      end

    end

    context "Device.count" do

      setup do
        @inputs = UniMIDI::Input.all
      end

      should "count all of the inputs" do
        assert_equal TestHelper.mock_devices[:input].count, UniMIDI::Input.count
      end

    end

    context "Device.find_by_name" do

      setup do
        @name = UniMIDI::Output.all.map(&:name).sample
        @output = UniMIDI::Output.find_by_name(@name)
      end

      should "select the correct input" do
        assert_equal @name, @output.name
      end

    end

    context "Device.first" do

      setup do
        @output_to_test = UniMIDI::Output.all[0]
        @output_to_test.expects(:open).returns(true)
        @output_to_test.expects(:enabled?).returns(true)
        @output = UniMIDI::Output.first
      end

      teardown do
        @output_to_test.unstub(:open)
        @output_to_test.unstub(:enabled?)   
      end

      teardown do
        @output_to_test.unstub(:open)
      end

      should "return the first output" do
        assert_equal @output_to_test, @output
      end
    end

  end
end
