require "midi-jruby"

module UniMIDI

  module Adapter

    module MIDIJRuby

      module Loader

        extend self

        def inputs
          ::MIDIJRuby::Device.all_by_type[:inputs]
        end

        def outputs
          ::MIDIJRuby::Device.all_by_type[:outputs]
        end

      end

    end

  end

end
