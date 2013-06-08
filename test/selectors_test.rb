require 'helper'

class SelectorTest < UniMIDI::TestCase

  def test_first
    i = Input.first
    assert_equal(Input.all.first, i)
  end

  def test_last
    i = Input.last
    assert_equal(Input.all.last, i)    
  end
  
  def test_first_with_block
    sleep(1)
    i = Input.first do |i|
      assert_equal(true, i.enabled?)
    end
    assert_equal(Input.all.first, i)
  end
  
  def test_last_with_block
    sleep(1)
    i = Input.last do |i|
      assert_equal(true, i.enabled?)     
    end
    assert_equal(Input.all.last, i)     
  end
  
  def test_brackets
    i = Input[0]
    assert_equal(Input.first, i)
    assert_equal(Input.all.first, i)
  end
  
  def test_use_with_block
    sleep(1)
    i = Input.use(0) do |i|
      assert_equal(true, i.enabled?) 
    end
    assert_equal(Input.first, i)
    assert_equal(Input.all.first, i)    
  end
  
  def test_use_with_symbol
    sleep(1)
    i = Input.use(:first)
    assert_equal(true, i.enabled?) 
    assert_equal(Input.first, i)
    assert_equal(Input.all.first, i)       
  end
  
  def test_all
    i = Input.all
    assert_equal(Device.all_by_type[:input], Input.all)
  end
  
end
