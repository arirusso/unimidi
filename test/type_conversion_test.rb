require 'helper'

class TypeConversionTest < Test::Unit::TestCase
  
  def test_numeric_byte_array_to_hex_string
    result = UniMIDI::TypeConversion.numeric_byte_array_to_hex_string([0x90, 0x40, 0x40])
    assert "904040", result
  end
  
end
