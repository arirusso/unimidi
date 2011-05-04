#!/usr/bin/env ruby
#
# A realtime MIDI interface for Ruby
# (c)2010-2011 Ari Russo and licensed under the Apache 2.0 License
#

module UniMIDI
  
  VERSION = "0.1.3"
 
end

require 'unimidi/congruous_api_adapter'
require 'unimidi/platform'

module UniMIDI
  extend(Platform.instance.interface)
  include(Platform.instance.interface)
end
