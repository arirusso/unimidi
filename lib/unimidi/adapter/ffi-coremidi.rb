require "coremidi"

module UniMIDI

  module Adapter

    module CoreMIDI

      module Loader

        extend self

        def inputs
          ::CoreMIDI::Endpoint.all_by_type[:source]
        end

        def outputs
          ::CoreMIDI::Endpoint.all_by_type[:destination]
        end

      end

    end

  end

end
