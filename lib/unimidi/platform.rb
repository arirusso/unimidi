module UniMIDI

  class Platform

    attr_reader :adapter_module

    def self.adapter_module
      @instance ||= new
      @instance.adapter_module
    end

    def initialize
      boot
    end

    def gem_name
      case RUBY_PLATFORM
      when /darwin/ then "ffi-coremidi"
      when /java/ then "midi-jruby"
      when /linux/ then "alsa-rawmidi"
      when /mingw/ then "midi-winmm"
      end
    end

    def gem_module
      case RUBY_PLATFORM
      when /darwin/ then CoreMIDIAdapter
      when /java/ then MIDIJRubyAdapter
      when /linux/ then AlsaRawMIDIAdapter
      when /mingw/ then MIDIWinMMAdapter
      end
    end

    private

    def boot
      require("unimidi/adapter/#{gem_name}")
      @adapter_module = gem_module
    end

  end

end
