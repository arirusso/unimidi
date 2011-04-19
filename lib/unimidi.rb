#!/usr/bin/env ruby
#
# A realtime MIDI interface for Ruby
#
module UniMIDI
  
  VERSION = "0.0.1"
 
end

require 'unimidi/platform'

module UniMIDI
  extend(Platform.instance.interface)
  include(Platform.instance.interface)
end