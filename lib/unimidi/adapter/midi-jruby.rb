require 'midi-jruby'

module UniMIDI

  module AlsaRawMIDIAdapter
    
    class Device
      extend CongruousApiAdapter::Device::ClassMethods
      defer_to MIDIJRuby::Device
    end
    
    class Input
      include CongruousApiAdapter::Device
      include CongruousApiAdapter::Input
      defer_to MIDIJRuby::Input
    end

    class Output
      include CongruousApiAdapter::Device
      include CongruousApiAdapter::Output
      defer_to MIDIJRuby::Output
    end

  end

end