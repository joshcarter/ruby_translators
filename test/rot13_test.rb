require_relative 'test_helper'

class Rot13Test < Test::Unit::TestCase
  def setup
    @source = StringIO.new
    @rot13 = Rot13Translator.new(@source)
  end
  
  def test_read_rot13
    @rot13.write "hello world"
    @source.rewind
    
    assert_equal "uryyb jbeyq", @source.read
  end  
end