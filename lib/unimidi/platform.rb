require 'singleton'

module UniMIDI
    
    class Platform
      
      include Singleton

      attr_reader :interface
      
      def initialize
        lib = case RUBY_PLATFORM
          when /linux/ then 'alsa-rawmidi'
          when /win/ then 'midi-winmm'
          when /mingw/ then 'midi-winmm' #cygwin
        end
        require(lib)
        require("unimidi/adapter/#{lib}")
        @interface = case RUBY_PLATFORM
          when /linux/ then AlsaRawMIDIAdapter
          when /win/ then MIDIWinMMAdapter 
          when /mingw/ then MIDIWinMMAdapter #cygwin
        end
      end

  end

end

