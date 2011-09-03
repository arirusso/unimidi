#!/usr/bin/env ruby

dir = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift dir + '/../lib'

require 'test/unit'
require 'unimidi'

module TestHelper
  
  TestSysex = !RUBY_PLATFORM.include?("java")
  
  def self.select_devices
    $test_device ||= {}
    { :input => UniMIDI::Input.all, :output => UniMIDI::Output.all }.each do |type, devs|
      puts ""
      puts "select an #{type.to_s}..."
      while $test_device[type].nil?
        devs.each do |device|
          puts device.pretty_name
        end
        selection = $stdin.gets.chomp
        if selection != ""
          selection = selection.to_i
          $test_device[type] = devs.find { |d| d.id == selection }
          puts "selected #{selection} for #{type.to_s}" unless $test_device[type]
        end
      end
    end
  end 
  
  def platform_test(adapter, mod, device_class = nil, input_class = nil, output_class = nil)
    device_class ||= mod::Device
    input_class ||= mod::Input
    output_class ||= mod::Output
    assert_equal(adapter, UniMIDI::Platform.instance.interface)
    assert_not_same(input_class, UniMIDI::Input)
    assert_not_same(output_class, UniMIDI::Output)
    assert_not_same(device_class, UniMIDI::Device)
    assert_equal(input_class.first.name, UniMIDI::Input.first.name)
    assert_equal(input_class.first.id, UniMIDI::Input.first.id)
    assert_not_same(output_class.first, UniMIDI::Output.first)
    assert_equal(output_class.first.name, UniMIDI::Output.first.name)
    assert_equal(output_class.first.id, UniMIDI::Output.first.id)
  end
	    
  def bytestrs_to_ints(arr)
    data = arr.map { |m| m[:data] }.join
      output = []
      until (bytestr = data.slice!(0,2)).eql?("")
        output << bytestr.hex
      end
    output    	
  end
  
  class MIDIObj
    def initialize(*bytes)
      @bytes = bytes
    end
    def to_bytes
      @bytes
    end
  end 
  
  # some MIDI messages
  VariousMIDIObjects = [
    TestSysex ? MIDIObj.new(0xF0, 0x41, 0x10, 0x42, 0x12, 0x40, 0x00, 0x7F, 0x00, 0x41, 0xF7) : nil, # SysEx
    MIDIObj.new(0x90, 100, 100), # note on
    MIDIObj.new(0x90, 43, 100), # note on
    MIDIObj.new(0x90, 76, 100), # note on
    MIDIObj.new(0x90, 60, 100), # note on
    MIDIObj.new(0x80, 100, 100) # note off
  ].compact
    
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

TestHelper.select_devices