module UniMIDI

  module CongruousApiAdapter

    module Device
      
      def initialize(device_obj)
        @device = device_obj
        @id = @device.id
        @name = @device.name
      end
      
      def open(*a, &block)
        begin
          @device.open(*a)
          block.call(self)
        ensure
          close
        end
      end
      
      def close(*a)
        @device.close(*a)
      end

      def self.included(base)
        #base.send(:attr_reader, :device)
        base.send(:attr_reader, :name)
        base.send(:attr_reader, :id)
      end

      module ClassMethods
        
        def first         
          new(device_class.first)
        end
        
        def last
          new(device_class.last)
        end
        
        def all
          all_by_type.values.flatten
        end
        
        def all_by_type
          { 
            :input => device_class.all_by_type[:input].map { |d| get_input_class.new(d) },
            :output => device_class.all_by_type[:output].map { |d| get_output_class.new(d) }
          }
        end
        
        def defer_to(klass)
          const_set("DeferToClass", klass)
        end
        
        def get_input_class
          const_get("InputClass")
        end
        
        def get_output_class
          const_get("OutputClass")
        end

        def input_class(klass)
          const_set("InputClass", klass)
        end
        
        def output_class(klass)
          const_set("OutputClass", klass)
        end
        
        def device_class
          const_get("DeferToClass")
        end

      end

    end

    module Input
   
      def self.included(base)
        base.extend(Device::ClassMethods)
        base.extend(ClassMethods)
      end

      #
      # returns an array of MIDI event hashes as such:
      # [
      #   { :data => [144, 60, 100], :timestamp => 1024 },
      #   { :data => [128, 60, 100], :timestamp => 1100 },
      #   { :data => [144, 40, 120], :timestamp => 1200 }
      # ]
      #
      # the data is an array of Numeric bytes
      # the timestamp is the number of millis since this input was enabled
      #
      def gets(*a)
        @device.gets(*a)
      end
      
      #
      # same as gets but returns message data as string of hex digits as such:
      # [ 
      #   { :data => "904060", :timestamp => 904 },
      #   { :data => "804060", :timestamp => 1150 },
      #   { :data => "90447F", :timestamp => 1300 }
      # ]
      #
      def gets_bytestr(*a)
        @device.gets_bytestr(*a)
      end

      #
      # returns an array of data bytes such as [144, 60, 100, 128, 60, 100, 144, 40, 120]
      #       
      def gets_data(*a)
        arr = gets
        arr.map { |msg| msg[:data] }.inject { |a,b| a + b }
      end

      #
      # returns a string of data such as "90406080406090447F"
      #             
      def gets_data_bytestr(*a)
        arr = gets_bytestr
        arr.map { |msg| msg[:data] }.join
      end
      
      module ClassMethods
             
        def all
          device_class.all.map { |d| new(d) }
        end
        
      end

    end

    module Output
      
      def self.included(base)
        base.extend(Device::ClassMethods)
        base.extend(ClassMethods)
      end
      
      def puts(*a)
        @device.puts(*a)
      end
      
      def puts_bytestr(*a)
        @device.puts_bytestr(*a)
      end
      
      module ClassMethods
        
        def all
          device_class.all.map { |d| new(d) }
        end
        
      end

    end

  end

end