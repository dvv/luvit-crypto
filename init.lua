require './build/lua-openssl/openssl'
local Crypto = openssl
_G.openssl = nil
return Crypto
