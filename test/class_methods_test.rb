require "helper"

class UniMIDI::ClassMethodsTest < UniMIDI::TestCase

  context "ClassMethods" do

    setup do
      TestDeviceHelper.setup
    end

    context "#first" do

      context "no block given" do
        should "return first input" do
          i = Input.first
          assert_equal(Input.all.first, i)
        end
      end

      context "block given" do
        should "pass and return first input" do
          sleep(1)
          i = Input.first do |i|
            assert_equal(true, i.enabled?)
          end
          assert_equal(Input.all.first, i)
        end

      end
    end

    context "#last" do

      context "no block given" do
        should "return last input" do
          i = Input.last
          assert_equal(Input.all.last, i)    
        end
      end

      context "block given" do
        should "pass and return last input" do
          sleep(1)
          i = Input.last do |i|
            assert_equal(true, i.enabled?)     
          end
          assert_equal(Input.all.last, i)     
        end

      end
    end

    context "#[]" do

      should "return correct input" do
        i = Input[0]
        assert_equal(Input.first, i)
        assert_equal(Input.all.first, i)
      end

    end

    context "#use" do

      context "block given" do
        should "return and enable an input" do
          sleep(1)
          i = Input.use(0) do |i|
            assert_equal(true, i.enabled?) 
          end
          assert_equal(Input.first, i)
          assert_equal(Input.all.first, i)    
        end

      end

      context "with symbol" do

        should "return an enabled input" do
          sleep(1)
          input = Input.use(:first)
          assert_equal(true, input.enabled?) 
          assert_equal(Input.first, input)
          assert_equal(Input.all.first, input)       
        end

      end

    end

    context "#all" do
      should "return all devices" do
        assert_equal(Loader.devices(:type => :input), Input.all)
      end
    end

  end

end
