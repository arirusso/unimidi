dir = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift dir + '/../lib'

require 'test/unit'
require 'unimidi'

module UniMIDI

  module TestHelper

    TestSysex = !RUBY_PLATFORM.include?("java") # java has problems with sysex messages on some versions of osx

    def self.select_devices
      $test_device ||= {}
      { :input => UniMIDI::Input, :output => UniMIDI::Output }.each do |type, klass|
        $test_device[type] = klass.gets
      end
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

  class TestCase <  Test::Unit::TestCase

    include UniMIDI
    include TestHelper

  end

end

UniMIDI::TestHelper.select_devices
