module UniMIDI

  module CongruousApiAdapter

    module OutputMethods

      module ClassMethods

        # All outputs
        def all
          UniMIDI::Device.all_by_type[:output]
        end

      end

      def self.included(base)
        base.send(:extend, ClassMethods)
      end

      # Send a message to the output. the message can be:
      #
      # bytes eg output.puts(0x90, 0x40, 0x40)
      # an array of bytes eg output.puts([0x90, 0x40, 0x40])
      # or a string eg output.puts("904040")
      # if none of those types are found, unimidi will attempt 
      # to call to_bytes and then to_a on the object
      #
      def puts(*a)
        case a.first
        when Array then puts_bytes(*a.first)
        when Numeric then puts_bytes(*a)
        when String then puts_s(*a)
        else
          if a.first.respond_to?(:to_bytes)
            puts_bytes(*a.first.to_bytes.flatten)
          elsif a.first.respond_to?(:to_a) 
            puts_bytes(*a.first.to_a.flatten)
          end
        end
      end

      # Send a message to the output in a form of a string eg "904040".  this method does not do
      # type checking and therefore is more performant than puts
      def puts_s(*a)
        @device.puts_s(*a)
      end
      alias_method :puts_bytestr, :puts_s
      alias_method :puts_hex, :puts_s

      # Send a message to the output in a form of bytes eg output.puts_bytes(0x90, 0x40, 0x40).
      # this method does not do type checking and therefore is more performant than puts
      def puts_bytes(*a)
        @device.puts_bytes(*a)
      end

    end

  end

end
