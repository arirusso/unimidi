require 'singleton'

module UniMIDI
    
    class Platform
      
      include Singleton

      attr_reader :interface
      
      def initialize
        lib = case RUBY_PLATFORM
          when /linux/ then 'alsa-rawmidi'
          when /win32/ then 'midi-winmm'
        end
        require(lib)
        require("unimidi/adapter/#{lib}")
        @interface = case RUBY_PLATFORM
          when /linux/ then AlsaRawMIDIAdapter
          when /win32/ then MIDIWinMMAdapter
        end
      end

  end

end

