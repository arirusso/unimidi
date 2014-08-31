require "midi-winmm"

module UniMIDI

  module Adapter

    module MIDIWinMM

      module Loader

        extend self

        def inputs
          ::MIDIWinMM::Device.all_by_type[:input]
        end

        def outputs
          ::MIDIWinMM::Device.all_by_type[:output]
        end

      end

    end

  end

end
