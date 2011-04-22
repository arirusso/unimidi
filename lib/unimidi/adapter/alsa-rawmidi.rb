module UniMIDI

  module AlsaRawMIDIAdapter
    
    class Device
      extend CongruousApiAdapter::Device::ClassMethods
      defer_to AlsaRawMIDI::Device
    end
    
    class Input
      include CongruousApiAdapter::Device
      include CongruousApiAdapter::Input
      defer_to AlsaRawMIDI::Input
    end

    class Output
      include CongruousApiAdapter::Device
      include CongruousApiAdapter::Output
      defer_to AlsaRawMIDI::Output
    end

  end

end