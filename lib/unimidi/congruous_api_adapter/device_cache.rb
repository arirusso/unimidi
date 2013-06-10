module UniMIDI

  module CongruousApiAdapter

    # Store the adapted versions of the device classes
    class DeviceCache

      class << self

        attr_accessor :devices, :device_class, :input_class, :output_class, :source_key

        def initialize
          @source_key = { :input => :input, :output => :output }
        end

        # If the cache isn't populated with adapted device objects yet, do so
        def ensure_initialized
          populate unless initialized?
        end

        private

        # Instantiate an adapted device object, given the raw unadapted version and the class to use
        def as_adapter(raw_device, klass)
          klass = klass || self
          klass.new(raw_device)
        end

        # Populate the device cache with adapted versions of all of the device objects
        def populate
          inputs = raw_inputs.map { |device| as_adapter(device, @input_class) }
          outputs = raw_outputs.map { |device| as_adapter(device, @output_class) }
          @devices = {
            :input => inputs,
            :output => outputs
          }   
        end
        alias_method :refresh, :populate

        # Has DeviceCache#populate been called yet?
        def initialized?
          instance_variable_defined?(:@devices) && !@devices.nil?
        end

        # The definitive list of raw, unadapted output device objects
        def raw_inputs
          @device_class.all_by_type[@source_key[:input]]
        end

        # The definitive list of raw, unadapted output device objects
        def raw_outputs
          @device_class.all_by_type[@source_key[:output]]
        end

      end

    end

  end

end
