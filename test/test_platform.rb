#!/usr/bin/env ruby

require 'helper'

class PlatformTest < Test::Unit::TestCase

  include UniMIDI
  include TestHelper
  include TestHelper::Config
    
  def test_jruby
    if RUBY_PLATFORM.include?("java")
      assert_equal(MIDIJRubyAdapter, UniMIDI::Platform.instance.interface)
      assert_not_same(MIDIJRuby::Input, UniMIDI::Input)
      assert_not_same(MIDIJRuby::Output, UniMIDI::Output)
      assert_not_same(MIDIJRuby::Device, UniMIDI::Device)
      assert_equal(MIDIJRuby::Input.first.name, UniMIDI::Input.first.name)
      assert_equal(MIDIJRuby::Input.first.id, UniMIDI::Input.first.id)
      assert_not_same(MIDIJRuby::Output.first, UniMIDI::Output.first)
      assert_equal(MIDIJRuby::Output.first.name, UniMIDI::Output.first.name)
      assert_equal(MIDIJRuby::Output.first.id, UniMIDI::Output.first.id)
    end
  end
    
  def test_linux
    if RUBY_PLATFORM.include?("linux")
      assert_equal(AlsaRawMIDIAdapter, UniMIDI::Platform.instance.interface)
      assert_not_same(AlsaRawMIDI::Input, UniMIDI::Input)
      assert_not_same(AlsaRawMIDI::Output, UniMIDI::Output)
      assert_not_same(AlsaRawMIDI::Device, UniMIDI::Device)
      assert_not_same(AlsaRawMIDI::Input.first, UniMIDI::Input.first)
      assert_equal(AlsaRawMIDI::Input.first.name, UniMIDI::Input.first.name)
      assert_equal(AlsaRawMIDI::Input.first.id, UniMIDI::Input.first.id)
      assert_not_same(AlsaRawMIDI::Output.first, UniMIDI::Output.first)
      assert_equal(AlsaRawMIDI::Output.first.name, UniMIDI::Output.first.name)
      assert_equal(AlsaRawMIDI::Output.first.id, UniMIDI::Output.first.id)
    end  
  end
  
  def test_osx
    if RUBY_PLATFORM.include?("darwin")
      assert_equal(CoreMIDIAdapter, UniMIDI::Platform.instance.interface)
      assert_not_same(CoreMIDI::Input, UniMIDI::Input)
      assert_not_same(CoreMIDI::Output, UniMIDI::Output)
      assert_not_same(CoreMIDI::Device, UniMIDI::Device)
      assert_equal(CoreMIDI::Input.first.name, UniMIDI::Input.first.name)
      assert_equal(CoreMIDI::Input.first.id, UniMIDI::Input.first.id)
      assert_not_same(CoreMIDI::Output.first, UniMIDI::Output.first)
      assert_equal(CoreMIDI::Output.first.name, UniMIDI::Output.first.name)
      assert_equal(CoreMIDI::Output.first.id, UniMIDI::Output.first.id)
    end  
  end
  
  def test_windows
    if RUBY_PLATFORM.include?("win") || RUBY_PLATFORM.include?("mingw")
      assert_equal(MIDIWinMMAdapter, UniMIDI::Platform.instance.interface)
      assert_not_same(MIDIWinMM::Input, UniMIDI::Input)
      assert_not_same(MIDIWinMM::Output, UniMIDI::Output)
      assert_not_same(MIDIWinMM::Device, UniMIDI::Device)
      assert_equal(MIDIWinMM::Input.first.name, UniMIDI::Input.first.name)
      assert_equal(MIDIWinMM::Input.first.id, UniMIDI::Input.first.id)
      assert_not_same(MIDIWinMM::Output.first, UniMIDI::Output.first)
      assert_equal(MIDIWinMM::Output.first.name, UniMIDI::Output.first.name)
      assert_equal(MIDIWinMM::Output.first.id, UniMIDI::Output.first.id)
    end
  end  
  
end