require 'helper'

class PlatformTest < UniMIDI::TestCase

  def platform(adapter, mod, options = {})
    device_class = options[:device_class] || mod::Device
    input_class = options[:input_class] || mod::Input
    output_class = options[:output_class] || mod::Output
    assert_equal(adapter, UniMIDI::Platform.adapter_module)
    assert_not_same(input_class, UniMIDI::Input)
    assert_not_same(output_class, UniMIDI::Output)
    assert_not_same(device_class, UniMIDI::Device)
    unless input_class.nil?
      assert_equal(input_class.first.name, UniMIDI::Input.first.name)
      assert_equal(input_class.first.id, UniMIDI::Input.first.id)
    end
    unless output_class.nil?
      assert_not_same(output_class.first, UniMIDI::Output.first)
      assert_equal(output_class.first.name, UniMIDI::Output.first.name)
      assert_equal(output_class.first.id, UniMIDI::Output.first.id)
    end
  end

  def test_jruby
    if RUBY_PLATFORM.include?("java")
      platform(MIDIJRubyAdapter, MIDIJRuby)
    end
  end

  def test_linux
    if RUBY_PLATFORM.include?("linux")
      platform(AlsaRawMIDIAdapter, AlsaRawMIDI)
    end  
  end

  def test_osx
    if RUBY_PLATFORM.include?("darwin")
      platform(CoreMIDIAdapter, CoreMIDI, :device_class => CoreMIDI::Endpoint, :input_class => CoreMIDI::Source, :output_class => CoreMIDI::Destination)
    end  
  end

  def test_windows
    if RUBY_PLATFORM.include?("mingw")
      platform(MIDIWinMMAdapter, MIDIWinMM)
    end
  end  

end
