require 'helper'

class CongruousApiAdapterTest < UniMIDI::TestCase
  
  def test_input_type
    i = $test_device[:input]
    assert_equal(:input, i.type)
  end
  
  def test_output_type
    o = $test_device[:output]
    assert_equal(:output, o.type)    
  end
  
end
