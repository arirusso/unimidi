#!/usr/bin/env ruby
#

require 'coremidi'

module UniMIDI

  module CoreMIDIAdapter
    
    class Input
      include CongruousApiAdapter::Device
      include CongruousApiAdapter::Input
      defer_to CoreMIDI::Input
    end

    class Output
      include CongruousApiAdapter::Device
      include CongruousApiAdapter::Output
      defer_to CoreMIDI::Output
    end
    
    class Device
      extend CongruousApiAdapter::Device::ClassMethods
      defer_to CoreMIDI::Device
      input_class Input
      output_class Output
    end
    
  end

end