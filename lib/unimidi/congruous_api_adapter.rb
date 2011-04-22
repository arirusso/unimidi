module UniMIDI

  module CongruousApiAdapter

    module Device
      
      def initialize(device_obj)
        @device = device_obj
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
        base.send(:attr_reader, :device)
      end

      module ClassMethods
        
        def first         
          new(device_class.first)
        end
        
        def last
          new(device_class.last)
        end
        
        def all
          device_class.all.map { |d| new(d) }
        end
        
        def all_by_type
          { 
            :input => device_class.all_by_type[:input].map { |d| new(d) },
            :output => device_class.all_by_type[:output].map { |d| new(d) }
          }
        end
        
        def defer_to(klass)
          const_set("DeferToClass", klass)
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

      def gets(*a)
        @device.gets(*a)
      end
      
      def gets_bytestr(*a)
        @device.gets_bytestr(*a)
      end
      
      module ClassMethods
        
        def self.all
          device_class.all_by_type[:input].map { |d| new(d) }
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
        
        def self.all
          device_class.all_by_type[:output].map { |d| new(d) }
        end
        
      end

    end

  end

end