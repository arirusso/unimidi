module UniMIDI

  module AlsaRawMIDIAdapter
    
    class Input
      include CongruousApiAdapter::Device
      extend CongruousApiAdapter::Device::ClassMethods
      DeviceClass = ::AlsaRawMIDI::Input
    end

    class Output
      include CongruousApiAdapter::Device
      extend CongruousApiAdapter::Device::ClassMethods
      DeviceClass = ::AlsaRawMIDI::Output
    end

  end

end