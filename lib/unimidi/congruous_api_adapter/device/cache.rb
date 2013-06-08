module UniMIDI

  module CongruousApiAdapter

    module Device

      class Cache

        class << self

          attr_accessor :devices, :device_class, :input_class, :output_class, :source_key

          def initialize
            @source_key = { :input => :input, :output => :output }
          end

          def ensure_initialized
            populate unless initialized?
          end

          private
          
          def as_adapter(device, klass)
            klass = klass || self
            klass.new(device)
          end

          def populate
            inputs = raw_inputs.map { |device| as_adapter(device, @input_class) }
            outputs = raw_outputs.map { |device| as_adapter(device, @output_class) }
            @devices = {
              :input => inputs,
              :output => outputs
            }   
          end
          alias_method :refresh, :populate

          def initialized?
            instance_variable_defined?(:@devices) && !@devices.nil?
          end

          def raw_inputs
            @device_class.all_by_type[@source_key[:input]]
          end

          def raw_outputs
            @device_class.all_by_type[@source_key[:output]]
          end

        end

      end

    end

  end

end

