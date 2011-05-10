#!/usr/bin/env ruby
#

require 'alsa-rawmidi'

module UniMIDI

  module AlsaRawMIDIAdapter
    
    class Input < CongruousApiInput
      defer_to AlsaRawMIDI::Input
    end

    class Output < CongruousApiOutput
      defer_to AlsaRawMIDI::Output
    end
    
    class Device < CongruousApiDevice
      defer_to AlsaRawMIDI::Device
      input_class Input
      output_class Output
    end
    
  end

end