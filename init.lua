require './build/lua-openssl/openssl'
local Crypto = openssl
_G.openssl = nil

--
-- helpers
--

local String = require('string')
local gsub = String.gsub
local format = String.format
local byte = String.byte

local function tohex(str)
  return (gsub(str, '(.)', function(c)
    return format('%02x', byte(c))
  end))
end

local function fromhex(str)
  return (gsub(str, '(%x%x)', function(h)
    local n = tonumber(h, 16)
    if n ~= 0 then
      return format('%c', n)
    else
      return '\000'
    end
  end))
end

local function digest(method, salt, data, raw)
  local digest = Crypto.get_digest(method, salt):init()
  digest:update(data)
  local result = digest:final()
  if not raw then result = tohex(result) end
  return result
end

--
-- sugar
--

Crypto.md5 = function(data, raw)
  return digest('md5', nil, data, raw)
end

Crypto.sha1 = function(data, raw)
  return digest('sha1', nil, data, raw)
end

Crypto.sign = function(secret, data)
  return digest('sha1', secret, data, true)
end

Crypto.encrypt = function(secret, data, raw)
  local cipher = Crypto.get_cipher('aes192')
  local result = cipher:encrypt(data, secret)
  if not raw then result = tohex(result) end
  return result
end

Crypto.uncrypt = function(secret, data, raw)
  local cipher = Crypto.get_cipher('aes192')
  if not raw then data = fromhex(data) end
  return cipher:decrypt(data, secret)
end

return Crypto
