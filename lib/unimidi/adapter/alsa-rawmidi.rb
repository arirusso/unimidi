require 'alsa-rawmidi'

module UniMIDI

  module AlsaRawMIDIAdapter
    
    class Input < CongruousApiAdapter::Input
      defer_to AlsaRawMIDI::Input
      device_class AlsaRawMIDI::Device
    end

    class Output < CongruousApiAdapter::Output
      defer_to AlsaRawMIDI::Output
      device_class AlsaRawMIDI::Device
    end
    
    class Device < CongruousApiAdapter::Device
      defer_to AlsaRawMIDI::Device
      input_class Input
      output_class Output
    end
    
  end

end
