require "helper"

class UniMIDI::PlatformTest < Minitest::Test

  context "Platform" do

    context ".bootstrap" do

      if RUBY_PLATFORM.include?("java")
        should "recognize java" do
          assert_equal(UniMIDI::Adapter::MIDIJRuby::Loader, UniMIDI::Loader.instance_variable_get("@loader"))
        end
      end

      if RUBY_PLATFORM.include?("linux")
        should "recognize linux" do
          assert_equal(UniMIDI::Adapter::AlsaRawMIDI::Loader, UniMIDI::Loader.instance_variable_get("@loader"))
        end
      end

      if RUBY_PLATFORM.include?("darwin")
        should "recognize osx" do
          assert_equal(UniMIDI::Adapter::CoreMIDI::Loader, UniMIDI::Loader.instance_variable_get("@loader"))
        end
      end

      if RUBY_PLATFORM.include?("mingw")
        should "recognize windows" do
          assert_equal(UniMIDI::Adapter::MIDIWinMM::Loader, UniMIDI::Loader.instance_variable_get("@loader"))
        end
      end

    end

  end

end
