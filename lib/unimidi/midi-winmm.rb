module UniMIDI

  module MIDIWinMMAdapter
    
    class Input
      include CongruousApiAdapter::Device
      extend CongruousApiAdapter::Device::ClassMethods
      DeviceClass = ::MIDIWinMM::Input
    end

    class Output
      include CongruousApiAdapter::Device
      extend CongruousApiAdapter::Device::ClassMethods
      DeviceClass = ::MIDIWinMM::Output
    end

  end

end