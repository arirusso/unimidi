require "helper"

class UniMIDI::DeviceTest < Minitest::Test

  context "Device" do

    setup do
      UniMIDI::Input.stubs(:all).returns(TestHelper.mock_devices[:input])
      UniMIDI::Output.stubs(:all).returns(TestHelper.mock_devices[:output])
    end

    teardown do
      UniMIDI::Input.unstub(:all)
      UniMIDI::Output.unstub(:all)
    end

    context "InstanceMethods" do

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

    end

    context "ClassMethods" do

      context ".find_by_name" do

        setup do
          @name = UniMIDI::Output.all.map(&:name).sample
          @output = UniMIDI::Output.find_by_name(@name)
        end

        should "select the correct input" do
          assert_equal(@name, @output.name)
        end

      end

      context ".first" do

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

        should "return the first output" do
          assert_equal(@output_to_test, @output)
        end

      end

      context ".last" do

        setup do
          @output_to_test = UniMIDI::Output.all.last
          @output_to_test.expects(:open).returns(true)
          @output_to_test.expects(:enabled?).returns(true)
          @output = UniMIDI::Output.last
        end

        teardown do
          @output_to_test.unstub(:open)
          @output_to_test.unstub(:enabled?)
        end

        should "return the last output" do
          assert_equal @output_to_test, @output
        end

      end

      context ".[]" do

        setup do
          @device_to_test = UniMIDI::Input.all[0]
          @device_to_test.expects(:open).returns(true)
          @device_to_test.expects(:enabled?).returns(true)
          @device = UniMIDI::Input[0]
        end

        teardown do
          @device_to_test.unstub(:open)
          @device_to_test.unstub(:enabled?)
        end

        should "return correct input" do
          assert_equal(@device_to_test, @device)
        end

      end

      context ".use" do

        context "block given" do

          setup do
            @device_to_test = UniMIDI::Input.all.sample
            @index = UniMIDI::Input.all.index(@device_to_test)
            @device_to_test.expects(:open).returns(true)
            @device_to_test.expects(:enabled?).at_least_once.returns(true)
          end

          teardown do
            @device_to_test.unstub(:open)
            @device_to_test.unstub(:enabled?)
          end

          should "return and enable an input" do
            @device = nil
            UniMIDI::Input.use(@index) do |device|
              @device = device
              assert(@device.enabled?)
            end
            assert_equal(UniMIDI::Input.at(@index), @device)
          end

        end

        context "with symbol" do

          setup do
            @device_to_test = UniMIDI::Output.all.sample
            @index = UniMIDI::Output.all.index(@device_to_test)
            @device_to_test.expects(:open).returns(true)
            @device_to_test.expects(:enabled?).at_least_once.returns(true)
          end

          teardown do
            @device_to_test.unstub(:open)
            @device_to_test.unstub(:enabled?)
          end

          should "return an enabled input" do
            @device = UniMIDI::Output.use(@index)
            assert(@device.enabled?)
            assert_equal(UniMIDI::Output.at(@index), @device)
          end

        end

      end

      context ".count" do

        setup do
          @inputs = UniMIDI::Input.all
          @outputs = UniMIDI::Output.all
        end

        should "have the correct number of inputs" do
          assert_equal(@inputs.count, UniMIDI::Input.count)
        end

        should "have the correct number of outputs" do
          assert_equal(@outputs.count, UniMIDI::Output.count)
        end

      end

    end

  end

end
