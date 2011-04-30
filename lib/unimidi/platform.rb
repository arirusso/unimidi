#!/usr/bin/env ruby
#
# (c)2010-2011 Ari Russo and licensed under the Apache 2.0 License
#

require 'singleton'

module UniMIDI
    
    class Platform
      
      include Singleton

      attr_reader :interface
      
      def initialize
        lib = case RUBY_PLATFORM
          when /java/ then 'midi-jruby'
          when /linux/ then 'alsa-rawmidi'
          when /mingw/ then 'midi-winmm' #cygwin
          when /win/ then 'midi-winmm'
        end
        require("unimidi/adapter/#{lib}")
        @interface = case RUBY_PLATFORM
          when /java/ then MIDIJRubyAdapter
          when /linux/ then AlsaRawMIDIAdapter
          when /mingw/ then MIDIWinMMAdapter #cygwin
          when /win/ then MIDIWinMMAdapter 
        end
      end

  end

end

