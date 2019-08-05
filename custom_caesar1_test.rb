require './custom_caesar1'
require 'minitest/autorun'
require 'pry'
require 'test/unit'

class CustomCaesar1Test < Test::Unit::TestCase
  def setup
    @caesar = CaesarCipher.new
    @plain_text = 'hello world'
  end

  def test_cipher_test_after_encoding
    cipher_text = @caesar.encode(@plain_text)
    assert_not_equal cipher_text, @plain_text
    assert_not_equal cipher_text, nil
  end
end

test = [4, 8,1 ,3 ]
test = [1,3,4,8]
