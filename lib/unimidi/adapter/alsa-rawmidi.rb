module UniMIDI

  module AlsaRawMIDIAdapter
    
    class Device
      extend CongruousApiAdapter::Device::ClassMethods
      DeviceClass = ::AlsaRawMIDI::Device
    end
    
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