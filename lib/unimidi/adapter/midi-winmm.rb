require 'midi-winmm'

module UniMIDI

  module MIDIWinMMAdapter
    
    class Input < CongruousApiAdapter::Input
      defer_to MIDIWinMM::Input
      device_class MIDIWinMM::Device
    end

    class Output < CongruousApiAdapter::Output
      defer_to MIDIWinMM::Output
      device_class MIDIWinMM::Device
    end
    
    class Device < CongruousApiAdapter::Device
      defer_to MIDIWinMM::Device
      input_class Input
      output_class Output
    end

  end

end
