module UniMIDI
  
  module Platform

    extend self
    
    def init
      lib = case RUBY_PLATFORM
        when /darwin/ then "ffi-coremidi"
        when /java/ then "midi-jruby"
        when /linux/ then "alsa-rawmidi"
        when /mingw/ then "midi-winmm"
      end
      require("unimidi/adapter/#{lib}")
      interface = case RUBY_PLATFORM
        when /darwin/ then Adapter::CoreMIDI
        when /java/ then Adapter::MIDIJRuby
        when /linux/ then Adapter::AlsaRawMIDI
        when /mingw/ then Adapter::MIDIWinMMAdapter
      end
      Loader.use(interface::Loader)
    end

  end

end
