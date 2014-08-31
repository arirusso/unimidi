require "midi-winmm"

module UniMIDI

  module Adapter

    module MIDIWinMM

      module Loader

        extend self

        def inputs
          ::MIDIWinMM::Device.all_by_type[:inputs]
        end

        def outputs
          ::MIDIWinMM::Device.all_by_type[:outputs]
        end

      end

    end

  end

end
