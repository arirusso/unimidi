#!/usr/bin/env ruby
#

require 'midi-winmm'

module UniMIDI

  module MIDIWinMMAdapter
    
    class Input
      include CongruousApiAdapter::Device
      include CongruousApiAdapter::Input
      DeferToClass = MIDIWinMM::Input
    end

    class Output
      include CongruousApiAdapter::Device
      include CongruousApiAdapter::Output
      DeferToClass = MIDIWinMM::Output
    end
    
    class Device
      extend CongruousApiAdapter::Device::ClassMethods
      DeferToClass = MIDIWinMM::Device
      InputClass = Input
      OutputClass = Output
    end

  end

end