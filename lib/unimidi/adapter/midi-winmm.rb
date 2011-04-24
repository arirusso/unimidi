require 'midi-winmm'

module UniMIDI

  module MIDIWinMMAdapter
    
    class Device
      extend CongruousApiAdapter::Device::ClassMethods
      defer_to MIDIWinMM::Device
    end
    
    class Input
      include CongruousApiAdapter::Device
      include CongruousApiAdapter::Input
      defer_to MIDIWinMM::Input
    end

    class Output
      include CongruousApiAdapter::Device
      include CongruousApiAdapter::Output
      defer_to MIDIWinMM::Output
    end

  end

end