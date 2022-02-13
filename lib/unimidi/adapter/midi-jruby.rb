# frozen_string_literal: true

require 'midi-jruby'

module UniMIDI
  module Adapter
    # Load underlying devices using the midi-jruby gem
    module MIDIJRuby
      module Loader
        module_function

        # @return [Array<MIDIJRuby::Input>]
        def inputs
          ::MIDIJRuby::Device.all_by_type[:input]
        end

        # @return [Array<MIDIJRuby::Output>]
        def outputs
          ::MIDIJRuby::Device.all_by_type[:output]
        end
      end
    end
  end
end
