module UniMIDI
    
    module AlsaRawMIDIAdapter
      
      module Device
        
        def self.all
          AlsaRawMIDI::Device.all  
        end
        
        def open(*a, &block)
          @device.open(*a) do |device|
            block.call(self)
          end
        end
        
      end
      
      class Input
        
        include Device
        
        def gets          
        end
        
      end
      
      class Output
        
        include Device
        
        attr_reader :device
        
        def initialize(device_obj)
          @device = device_obj
        end
        
        def puts(*a)
          @device.puts(*a)
        end
        
        def self.first
          new(AlsaRawMIDI::Output.first)
        end
        
      end
              
    end

end