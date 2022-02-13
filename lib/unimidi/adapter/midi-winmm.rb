# frozen_string_literal: true

require 'midi-winmm'

module UniMIDI
  module Adapter
    # Load underlying devices using the midi-winmm gem
    module MIDIWinMM
      module Loader
        module_function

        # @return [Array<MIDIWinMM::Input>]
        def inputs
          ::MIDIWinMM::Device.all_by_type[:input]
        end

        # @return [Array<MIDIWinMM::Output>]
        def outputs
          ::MIDIWinMM::Device.all_by_type[:output]
        end
      end
    end
  end
end
