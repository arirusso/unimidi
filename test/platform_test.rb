require 'helper'

class PlatformTest < UniMIDI::TestCase
  
  def test_jruby
    if RUBY_PLATFORM.include?("java")
      platform_test(MIDIJRubyAdapter, MIDIJRuby)
    end
  end
    
  def test_linux
    if RUBY_PLATFORM.include?("linux")
      platform_test(AlsaRawMIDIAdapter, AlsaRawMIDI)
    end  
  end
  
  def test_osx
    if RUBY_PLATFORM.include?("darwin")
      platform_test(CoreMIDIAdapter, CoreMIDI, CoreMIDI::Endpoint, CoreMIDI::Source, CoreMIDI::Destination)
    end  
  end
  
  def test_windows
    if RUBY_PLATFORM.include?("mingw")
      platform_test(MIDIWinMMAdapter, MIDIWinMM)
    end
  end  
  
end
