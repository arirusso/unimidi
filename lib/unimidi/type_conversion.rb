module UniMIDI
  
  module TypeConversion
      
    # Convert a byte array to string of hex bytes 
    def numeric_byte_array_to_hex_string(bytes)
      bytes.map { |b| b.hex }.join
    end
      
  end
  
end
