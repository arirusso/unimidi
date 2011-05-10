#!/usr/bin/env ruby
#

require 'midi-winmm'

module UniMIDI

  module MIDIWinMMAdapter
    
    class Input < CongruousApiInput
      defer_to MIDIWinMM::Input
    end

    class Output < CongruousApiOutput
      defer_to MIDIWinMM::Output
    end
    
    class Device < CongruousApiDevice
      defer_to MIDIWinMM::Device
      input_class Input
      output_class Output
    end

  end

end