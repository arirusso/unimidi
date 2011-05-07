#!/usr/bin/env ruby
#

require 'coremidi'

module UniMIDI

  module CoreMIDIAdapter
    
    class Input
      include CongruousApiAdapter::Device
      include CongruousApiAdapter::Input
      DeferToClass = CoreMIDI::Input
    end

    class Output
      include CongruousApiAdapter::Device
      include CongruousApiAdapter::Output
      DeferToClass = CoreMIDI::Output
    end
    
    class Device
      extend CongruousApiAdapter::Device::ClassMethods
      DeferToClass = CoreMIDI::Device
      InputClass = Input
      OutputClass = Output
    end
    
  end

end