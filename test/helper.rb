#!/usr/bin/env ruby

dir = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift dir + '/../lib'

require 'test/unit'
require 'unimidi'

module TestHelper
  
  TestSysex = !RUBY_PLATFORM.include?("java") 
  
  def platform_test(adapter, mod)
    assert_equal(adapter, UniMIDI::Platform.instance.interface)
    assert_not_same(mod::Input, UniMIDI::Input)
    assert_not_same(mod::Output, UniMIDI::Output)
    assert_not_same(mod::Device, UniMIDI::Device)
    assert_equal(mod::Input.first.name, UniMIDI::Input.first.name)
    assert_equal(mod::Input.first.id, UniMIDI::Input.first.id)
    assert_not_same(mod::Output.first, UniMIDI::Output.first)
    assert_equal(mod::Output.first.name, UniMIDI::Output.first.name)
    assert_equal(mod::Output.first.id, UniMIDI::Output.first.id)
  end
	    
  def bytestrs_to_ints(arr)
    data = arr.map { |m| m[:data] }.join
      output = []
      until (bytestr = data.slice!(0,2)).eql?("")
        output << bytestr.hex
      end
    output    	
  end
    
  # some MIDI messages
  VariousMIDIMessages = [
    TestSysex ? [0xF0, 0x41, 0x10, 0x42, 0x12, 0x40, 0x00, 0x7F, 0x00, 0x41, 0xF7] : nil, # SysEx
    [0x90, 100, 100], # note on
    [0x90, 43, 100], # note on
    [0x90, 76, 100], # note on
    [0x90, 60, 100], # note on
    [0x80, 100, 100] # note off
  ].compact
    
  # some MIDI messages
  VariousMIDIByteStrMessages = [
    TestSysex ? "F04110421240007F0041F7" : nil, # SysEx
    "906440", # note on
    "804340" # note off
  ].compact
    
end

require File.dirname(__FILE__) + '/config'
