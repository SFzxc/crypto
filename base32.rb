##
# Base32 Encoding Algorithm - RFC 4648
# http://www.herongyang.com/Encoding/Base32-Encoding-Algorithm.html
#
# Implementer: Long Hoang

require 'openssl'
require 'pry'

TABLE = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567'.chars

# Base32 encoding algorithm is designed to encode any binary data
class Base32
  def self.encode(str)
    # String to ASCII Dec array
    str_bytes = str.bytes # 'hoanglong'.bytes [104, 111, 97, 110, 103, 108, 111, 110, 103]

    # Divid the input bytes stream into blocks of 5 bytes.
    # An ASCII character in 8-bit ASCII encoding is 8 bits (1 byte)
    five_bytes_group = (str_bytes.size / 5.0).ceil

    total_bits_no = 5 * 8 * five_bytes_group # 5 bytes, 8 bits per bytes
    current_bits = str_bytes.map {|a| a.to_s(2).rjust(8,'0') }.join
    current_bits_size = current_bits.size
    current_bits_apend_zero = current_bits.ljust(total_bits_no,'0')
    # Divid 40 bits of each 5-byte block into 8 groups of 5 bits.
    encoded_str = ""
    loop_times = total_bits_no / 5
    (1..loop_times).each do |time|
      start_bit = time*5 - 5
      encode_char_pos = current_bits_apend_zero.slice(start_bit, 5).to_i(2)

      encode_char = if encode_char_pos.zero? && start_bit > current_bits_size
                      '='
                    else
                      encode_char = TABLE[encode_char_pos]
                    end
      encoded_str << encode_char
    end
    encoded_str
  end

  def self.decode(cipher)
    plain_text = ''
    bin_str = ''
    cipher.chars.each do |c|
      break if c == '='
      bin_str << TABLE.find_index(c).to_s(2).rjust(5, '0')
    end
    bin_str_size = bin_str.size
    loop_times = bin_str_size / 8
    (1..loop_times).each do |time|
      start_bit = time*8 - 8
      plain_text << [bin_str.slice(start_bit, 8).to_i(2)].pack('C*')
    end
    plain_text
  end
end
