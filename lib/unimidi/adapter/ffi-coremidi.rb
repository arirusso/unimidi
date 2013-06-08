require 'coremidi'

module UniMIDI

  module CoreMIDIAdapter

    CongruousApiAdapter::DeviceCache.source_key = { :input => :source, :output => :destination }

    class Input
      include CongruousApiAdapter::InputMethods

      adapts CoreMIDI::Endpoint
    end

    class Output
      include CongruousApiAdapter::OutputMethods

      adapts CoreMIDI::Endpoint

    end

    class Device
      extend CongruousApiAdapter::DeviceMethods

      input_class Input
      output_class Output

    end

  end

end
