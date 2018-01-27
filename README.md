This gem provides a P_hash data expansion function as described by [Section 5 of RFC 5246](https://tools.ietf.org/html/rfc5246#section-5).

# Usage

To calculate `P_SHA1`:

```ruby
hash_function = OpenSSL::Digest::SHA1.new
secret = 'asdf1234' # Also referred to as the "client secret" for WS-Trust
seed = 'qwer5678' # Also referred to as the "server secret" for WS-Trust

digest = PHash.new(hash_function, secret, seed)
```

### Specifying a hash function

For `P_SHA256`, `P_MD5`, or similar, simply initialize `PHash` with the appropriate hashing function:

```ruby
hash_function = OpenSSL::Digest::SHA256.new
PHash.new(hash_function, 'asdf1234', 'qwer5678').digest
```

### Key sizes

The default key size is 32 bytes. To use a different key size, specify that as the fourth argument:

```ruby
PHash.new(OpenSSL::Digest::SHA256.new, 'asdf1234', 'qwer5678', 64).digest # Results in a 64 byte key
```

### Base64 and hex digests

As a convenience, the `PHash` class also offers a `base64digest` and `hexdigest` method:

```ruby
hash_function = OpenSSL::Digest::SHA256.new
p_hash = PHash.new(hash_function, 'asdf1234', 'qwer5678')

p_hash.base64digest # Base64 encoded digest
p_hash.hexdigest # Hex encoded digest
```

# The P_hash function

Per RFC 5246, `P_hash()` is described as follows:

```
p_hash(client_secret, server_secret) = HMAC_hash(secret, A(1) + seed) +
                                       HMAC_hash(secret, A(2) + seed) +
                                       HMAC_hash(secret, A(3) + seed) + ...
```

Here '+' indicates concatenation.

`A()` is defined by:

```
A(0) = seed
A(i) = HMAC_hash(secret, A(i-1))
```
