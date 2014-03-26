require 'helper'

class CongruousApiAdapterTest < UniMIDI::TestCase
  
  def test_input_type
    input = $test_device[:input]
    assert_equal(:input, input.type)
  end
  
  def test_output_type
    output = $test_device[:output]
    assert_equal(:output, output.type)    
  end

  def test_count
    count = 0
    Input.all.each do |input|
      count += 1
    end

    assert_equal count, Input.count
  end

  def test_find_by_name
    index = rand(0..(Input.count-1))
    input = Input.all[index]
    selected_input = Input.find_by_name(input.name)
    assert_equal input, selected_input

    output = rand(0..(Output.count-1))
    output = Output.all[index]
    selected_input = Input.find_by_name(input.name)
    assert_equal input, selected_input
  end
  
end
