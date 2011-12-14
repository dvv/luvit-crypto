require './openssl'
local string = require ("string")
local Crypto = openssl
_G.openssl = nil
Crypto.to_hex = function (res)
	local i=1
	local s = ""
	while i<=#res do
		local ch = res:sub (i,i+1)
		s = s..string.format ("%02x", string.byte (ch))
		i = i+1
	end
	return s
end
return Crypto
