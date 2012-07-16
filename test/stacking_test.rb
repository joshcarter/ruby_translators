require_relative 'test_helper'

class StackingTest < Test::Unit::TestCase
  def test_can_stack_translators
    sink = StringIO.new
    mid = Translator.new(sink)
    source = Translator.new(mid)
    
    source.write "foo"
    sink.rewind
    assert_equal "foo", sink.read

    sink.write "bar"
    sink.rewind
    assert_equal "foobar", source.read
  end
end