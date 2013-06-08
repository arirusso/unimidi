require 'coremidi'

module UniMIDI

  module CoreMIDIAdapter

    CongruousApiAdapter::Device::Cache.source_key = { :input => :source, :output => :destination }

    class Input
      extend CongruousApiAdapter::Device::ClassMethods
      include CongruousApiAdapter::Device::InstanceMethods
      include CongruousApiAdapter::Input

      adapts CoreMIDI::Endpoint
    end

    class Output
      extend CongruousApiAdapter::Device::ClassMethods
      include CongruousApiAdapter::Device::InstanceMethods
      include CongruousApiAdapter::Output

      adapts CoreMIDI::Endpoint

    end

    class Device
      extend CongruousApiAdapter::Device::ClassMethods
      extend CongruousApiAdapter::Device

      input_class Input
      output_class Output

    end

  end

end
