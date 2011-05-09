#!/usr/bin/env ruby
#

require 'midi-jruby'

module UniMIDI

  module MIDIJRubyAdapter
    
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
    
    class Device
      extend CongruousApiAdapter::Device::ClassMethods
      defer_to MIDIJRuby::Device
      input_class Input
      output_class Output
    end

  end

end