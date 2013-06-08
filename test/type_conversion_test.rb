require 'helper'

class TypeConversionTest < UniMIDI::TestCase
  
  def test_numeric_byte_array_to_hex_string
    result = TypeConversion.numeric_byte_array_to_hex_string([0x90, 0x40, 0x40])
    assert "904040", result
  end
  
end
