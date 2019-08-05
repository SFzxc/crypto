require './base32'
require 'minitest/autorun'

class Base32Test < Minitest::Test
  def test_encode_1
    assert_equal Base32.encode('A'), "IE======"
  end

  def test_encode_2
    assert_equal Base32.encode('AB'), "IFBA===="
  end

  def test_encode_3
    assert_equal Base32.encode('ABC'), "IFBEG==="
  end

  def test_encode_4
    assert_equal Base32.encode('ABCD'), "IFBEGRA="
  end

  def test_encode_5
    assert_equal Base32.encode('ABCDE'), "IFBEGRCF"
  end

  def test_decode_1
    assert_equal Base32.decode('IE======'), "A"
  end

  def test_decode_2
    assert_equal Base32.decode('IFBA==='), "AB"
  end

  def test_decode_3
    assert_equal Base32.decode('IFBEG==='), "ABC"
  end

  def test_decode_4
    assert_equal Base32.decode('IFBEGRA='), "ABCD"
  end

  def test_decode_5
    assert_equal Base32.decode('IFBEGRCF'), "ABCDE"
  end
end
