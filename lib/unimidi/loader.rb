module UniMIDI

  module Loader

    extend self

    def use(adapter)
      @adapter = adapter
    end

    def devices(options = {})
      if @devices.nil?
        inputs = @adapter.inputs.map { |device| ::UniMIDI::Input.new(device) }
        outputs = @adapter.outputs.map { |device| ::UniMIDI::Output.new(device) }
        @devices = {
          :input => inputs,
          :output => outputs
        }
      end
      options[:type].nil? ? @devices.values.flatten : @devices[options[:type]]
    end

  end
end
