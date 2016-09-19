require "helper"
require "minitest/autorun"
require "mocha/test_unit"
require "shoulda-context"
require "unimidi"

module TestHelper

  module Unit

    extend self

    def sysex_ok?
      ENV["_system_name"] != "OSX" || !RUBY_PLATFORM.include?("java")
    end

    def mock_devices
      if @mock_devices.nil?
        @mock_devices = {
          input: [],
          output: []
        }
        2.times do |i|
          input = Object.new
          input.stubs(:type).returns(:input)
          input.stubs(:name).returns("MIDI Input #{i}")
          @mock_devices[:input] << input
        end
        3.times do |i|
          input = Object.new
          input.stubs(:type).returns(:output)
          input.stubs(:name).returns("MIDI Output #{i}")
          @mock_devices[:output] << input
        end
      end
      @mock_devices
    end

  end
end
