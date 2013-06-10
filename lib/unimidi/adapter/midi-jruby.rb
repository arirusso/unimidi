require 'midi-jruby'

module UniMIDI

  module MIDIJRubyAdapter
    
    class Input < CongruousApiAdapter::Input
      defer_to MIDIJRuby::Input
      device_class MIDIJRuby::Device
    end

    class Output < CongruousApiAdapter::Output
      defer_to MIDIJRuby::Output
      device_class MIDIJRuby::Device
    end
    
    class Device < CongruousApiAdapter::Device
      defer_to MIDIJRuby::Device
      input_class Input
      output_class Output
    end

  end

end
