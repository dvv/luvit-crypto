local Crypto = require('./build/crypto')
_G.crypto = nil

--
-- helpers
--

local String = require('string')
local gsub = String.gsub
local format = String.format
local byte = String.byte

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

Crypto.fromhex = fromhex

--
-- sugar
--

Crypto.sign = function(data, secret, raw)
  return Crypto.hmac.digest('sha1', data, secret, raw)
end

--[[Crypto.encrypt = function(data, secret, raw)
  local result = _Crypto.encrypt('aes192', data, secret)
  if not raw then result = _Crypto.hex(result) end
  return result
end

Crypto.uncrypt = function(data, secret, raw)
  if not raw then data = fromhex(data) end
  return _Crypto.decrypt('aes192', data, secret)
end]]--

return Crypto
