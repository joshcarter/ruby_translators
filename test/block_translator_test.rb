require_relative 'test_helper'

class BlockTranslatorTest < Test::Unit::TestCase
  def test_read_expands_to_block_size
    source = mock()
    source.expects(:read).with(4).returns('aaaa')
    
    bt = BlockTranslator.new(source, 4)
    
    assert_equal "aaa", bt.read(3)
  end

  def test_read_matching_block_size
    source = mock()
    source.expects(:read).with(4).returns('aaaa')
    
    bt = BlockTranslator.new(source, 4)
    
    assert_equal "aaaa", bt.read(4)
  end

  def test_read_larger_than_block_size
    source = mock()
    source.expects(:read).with(4).returns('aaaa', 'bbbb').times(2)
    
    bt = BlockTranslator.new(source, 4)
    
    assert_equal "aaaab", bt.read(5)
  end
  
  def test_read_with_offset
    source = mock()
    source.expects(:seek).with(52)
    source.expects(:read).with(4).returns('aaaa', 'bbbb', 'cccc').times(3)
    
    bt = BlockTranslator.new(source, 4)
    
    # Read with offset of 54 -- should result in a seek to 52 (nearest
    # block size under 54), then 3 block reads.
    assert_equal "aabbbbcc", bt.read(8, 54)
  end
  
  def test_write_expands_to_block_size
    dest = mock()
    dest.expects(:write).with("aa\0\0")
    
    bt = BlockTranslator.new(dest, 4)
    bt.write("aa")
  end

  def test_write_matching_block_size
    dest = mock()
    dest.expects(:write).with("aaaa")
    
    bt = BlockTranslator.new(dest, 4)
    bt.write("aaaa")
  end

  def test_write_larger_than_block_size
    dest = mock()
    dest.expects(:write).with("aaaa")
    dest.expects(:write).with("b\0\0\0")
    
    bt = BlockTranslator.new(dest, 4)
    bt.write("aaaab")
  end
  
  def test_write_with_offset
    dest = mock()
    dest.expects(:seek).with(52)
    dest.expects(:write).with("\0\0aa")
    dest.expects(:write).with("bbbb")
    dest.expects(:write).with("cc\0\0")
    
    bt = BlockTranslator.new(dest, 4)
    bt.write("aabbbbcc", 54)
  end
end
