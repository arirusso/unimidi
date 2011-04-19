#!/usr/bin/env ruby
#
# A realtime MIDI interface for Ruby
#
module UniMIDI
  
  VERSION = "0.0.4"
 
end

require 'unimidi/congruous_api_adapter'
require 'unimidi/platform'

module UniMIDI
  extend(Platform.instance.interface)
  include(Platform.instance.interface)
end
