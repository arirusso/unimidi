#!/usr/bin/env ruby
#

require 'coremidi'

module UniMIDI

  module CoreMIDIAdapter
    
    class Input < CongruousApiInput
      defer_to CoreMIDI::Input
    end

    class Output < CongruousApiOutput
      defer_to CoreMIDI::Output
    end
    
    class Device < CongruousApiDevice
      defer_to CoreMIDI::Entity
      input_class Input
      output_class Output
    end
    
  end

end