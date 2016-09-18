module UniMIDI

  # Deal with different dependencies between different user environments
  module Platform

    extend self

    # Loads the proper MIDI library and adapter for the user's environment
    def bootstrap
      require("unimidi/adapter/#{platform_lib}")
      Loader.use(platform_module::Loader)
    end

    private

    def platform_lib
      case RUBY_PLATFORM
        when /darwin/ then "ffi-coremidi"
        when /java/ then "midi-jruby"
        when /linux/ then "alsa-rawmidi"
        when /mingw/ then "midi-winmm"
      end
    end

    def platform_module
      case RUBY_PLATFORM
        when /darwin/ then Adapter::CoreMIDI
        when /java/ then Adapter::MIDIJRuby
        when /linux/ then Adapter::AlsaRawMIDI
        when /mingw/ then Adapter::MIDIWinMM
      end
    end

  end

end
