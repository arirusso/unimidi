#!/usr/bin/env ruby
#

require 'midi-jruby'

module UniMIDI

  module MIDIJRubyAdapter
    
    class Input < CongruousApiInput
      defer_to MIDIJRuby::Input
    end

    class Output < CongruousApiOutput
      defer_to MIDIJRuby::Output
    end
    
    class Device < CongruousApiDevice
      defer_to MIDIJRuby::Device
      input_class Input
      output_class Output
    end

  end

end