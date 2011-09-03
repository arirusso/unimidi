#!/usr/bin/env ruby
#

require 'coremidi'

module UniMIDI

  module CoreMIDIAdapter
    
    class Input < CongruousApiInput
      defer_to CoreMIDI::Source
      device_class CoreMIDI::Endpoint
    end

    class Output < CongruousApiOutput
      defer_to CoreMIDI::Destination
      device_class CoreMIDI::Endpoint
    end
    
    class Device < CongruousApiDevice
      defer_to CoreMIDI::Endpoint
      input_class Input
      output_class Output
        
      def self.populate
        klass = @deference[self].respond_to?(:all_by_type) ? @deference[self] : @device_class
        @devices = {
            :input => klass.all_by_type[:source].map { |d| @input_class.new(d) },
            :output => klass.all_by_type[:destination].map { |d| @output_class.new(d) }
          }          
      end
      
    end
    
  end

end