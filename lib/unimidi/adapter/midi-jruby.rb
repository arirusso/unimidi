#!/usr/bin/env ruby
#

require 'midi-jruby'

module UniMIDI

  module MIDIJRubyAdapter
    
    class Input
      include CongruousApiAdapter::Device
      include CongruousApiAdapter::Input
      DeferToClass = MIDIJRuby::Input
    end

    class Output
      include CongruousApiAdapter::Device
      include CongruousApiAdapter::Output
      DeferToClass = MIDIJRuby::Output
    end
    
    class Device
      extend CongruousApiAdapter::Device::ClassMethods
      DeferToClass = MIDIJRuby::Device
      InputClass = Input
      OutputClass = Output
    end

  end

end