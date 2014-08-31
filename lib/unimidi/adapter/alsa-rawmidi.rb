require "alsa-rawmidi"

module UniMIDI

  module Adapter

    module AlsaRawMIDI

      module Loader

        extend self

        def inputs
          ::AlsaRawMIDI::Device.all_by_type[:input]
        end

        def outputs
          ::AlsaRawMIDI::Device.all_by_type[:output]
        end

      end

    end

  end

end
