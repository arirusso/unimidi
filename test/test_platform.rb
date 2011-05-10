#!/usr/bin/env ruby

require 'helper'

class PlatformTest < Test::Unit::TestCase

  include UniMIDI
  include TestHelper
  include TestHelper::Config
    
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
      platform_test(CoreMIDIAdapter, CoreMIDI)
    end  
  end
  
  def test_windows
    if RUBY_PLATFORM.include?("mingw")
      platform_test(MIDIWinMMAdapter, MIDIWinMM)
    end
  end  
  
end