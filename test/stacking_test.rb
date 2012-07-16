require_relative 'test_helper'

class StackingTest < Test::Unit::TestCase
  def test_can_stack_writers
    sink = StringIO.new
    mid = Writer.new(sink)
    source = Writer.new(mid)
    
    source.write "foo"
    sink.rewind
    assert_equal "foo", sink.read
  end

  def test_can_stack_readers
    source = StringIO.new
    mid = Reader.new(source)
    sink = Reader.new(mid)
    
    source.write "foo"
    source.rewind
    assert_equal "foo", sink.read
  end
end