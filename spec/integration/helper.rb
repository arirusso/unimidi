# frozen_string_literal: true

require 'helper'
require 'rspec'
require 'unimidi'

module SpecHelper
  module Integration
    module_function

    def sysex_ok?
      ENV['_system_name'] != 'OSX' || !RUBY_PLATFORM.include?('java')
    end

    def devices
      if @devices.nil?
        @devices = {}
        { input: UniMIDI::Input, output: UniMIDI::Output }.each do |type, klass|
          @devices[type] = klass.gets
        end
      end
      @devices
    end

    def bytestrs_to_ints(arr)
      data = arr.map { |m| m[:data] }.join
      output = []
      until (bytestr = data.slice!(0, 2)).eql?('')
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

    def message_objects
      numeric_messages.map { |message| MIDIObj.new(*message) }
    end

    def numeric_messages
      messages = [
        [0x90, 100, 100], # NOTE: on
        [0x90, 43, 100], # NOTE: on
        [0x90, 76, 100], # NOTE: on
        [0x90, 60, 100], # NOTE: on
        [0x80, 100, 100] # NOTE: off
      ]
      messages << [0xF0, 0x41, 0x10, 0x42, 0x12, 0x40, 0x00, 0x7F, 0x00, 0x41, 0xF7] if sysex_ok?
      messages
    end

    def string_messages
      messages = [
        '906440', # NOTE: on
        '804340' # NOTE: off
      ]
      messages << 'F04110421240007F0041F7' if sysex_ok?
      messages
    end
  end
end
