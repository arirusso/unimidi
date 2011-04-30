#!/usr/bin/env ruby
#
# (c)2010-2011 Ari Russo and licensed under the Apache 2.0 License
#

require 'alsa-rawmidi'

module UniMIDI

  module AlsaRawMIDIAdapter
    
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
    
    class Device
      extend CongruousApiAdapter::Device::ClassMethods
      defer_to AlsaRawMIDI::Device
      input_class Input
      output_class Output
    end
    
  end

end