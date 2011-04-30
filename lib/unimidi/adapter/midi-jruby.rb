#!/usr/bin/env ruby
#
# (c)2010-2011 Ari Russo and licensed under the Apache 2.0 License
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