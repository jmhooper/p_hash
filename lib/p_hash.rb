require 'base64'
require 'openssl'

class PHash
  attr_reader :hash_function, :secret, :seed, :key_length, :digest

  def initialize(hash_function, secret, seed, key_length = 32)
    @hash_function = hash_function
    @secret = secret
    @seed = seed
    @key_length = key_length
    calculate_digest
  end

  def hexdigest
    @hexdigest ||= digest.unpack('H*').first
  end

  def base64digest
    @base64digest ||= Base64.strict_encode64(digest)
  end

  private

  def calculate_digest
    digest = ''
    while digest.length < key_length
      digest = digest + OpenSSL::HMAC.digest(
        hash_function,
        secret,
        next_a_value + seed
      )
    end
    @digest = digest[0...key_length]
  end

  def next_a_value
    @a_value = OpenSSL::HMAC.digest(
      hash_function,
      secret,
      @a_value || seed
    )
  end
end
