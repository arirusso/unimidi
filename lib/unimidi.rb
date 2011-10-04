#!/usr/bin/env ruby
#
# A realtime MIDI interface for Ruby
# (c)2010-2011 Ari Russo and licensed under the Apache 2.0 License
#

module UniMIDI
  
  VERSION = "0.3.1"
 
end

require 'forwardable'

require 'unimidi/congruous_api_adapter'
require 'unimidi/platform'
require 'unimidi/type_conversion'

module UniMIDI
  extend(Platform.instance.interface)
  include(Platform.instance.interface)
  
  def self.command(command, options = {})
    if [:l, :list, :list_devices].include?(command)
      puts "input:"
      Input.list
      puts "output:"
      Output.list
    else
      raise "Command #{command.to_s} not found"
    end      
  end
end
