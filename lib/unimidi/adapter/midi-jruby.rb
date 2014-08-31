require "midi-jruby"

module UniMIDI

  module Adapter

    module MIDIJRuby

      module Loader

        extend self

        def inputs
          ::MIDIJRuby::Device.all_by_type[:input]
        end

        def outputs
          ::MIDIJRuby::Device.all_by_type[:output]
        end

      end

    end

  end

end
