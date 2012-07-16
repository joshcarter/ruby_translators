require_relative 'test_helper'

class VerifyTranslatorTest < Test::Unit::TestCase
  def test_read_correct_data
    s1 = StringIO.new
    s2 = StringIO.new
    vt = VerifyTranslator.new(s1, s2, 16)
    vt.write "the quick brown fox jumped over the lazy dog"
    source.rewind

    assert_equal "the quick brown ", vt.read(16)
    assert_equal "fox jumped over ", vt.read(16)
  end
  
  def test_read_faulty_data
    assert true
  end
end