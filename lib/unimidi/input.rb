# frozen_string_literal: true

require 'unimidi/input/buffer_access'
require 'unimidi/input/stream_reader'

module UniMIDI
  # A MIDI input device
  class Input
    extend Device::ClassMethods
    include BufferAccess
    include Device::InstanceMethods
    include StreamReader

    # All MIDI input devices -- used to populate the class
    # @return [Array<Input>]
    def self.all
      Loader.devices(direction: :input)
    end
  end
end
