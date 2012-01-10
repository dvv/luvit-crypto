#!/usr/bin/env luvit

local Crypto = require('./')

-- sanity --
assert(Crypto)
assert(not _G.openssl)
assert(Crypto.get_cipher)

-- md5 of a string --
local md5 = Crypto.md5('hello world')
print('MD5', 'hello world', md5)
assert(md5 == '5eb63bbbe01eeed093cb22bb8f5acdc3')
local md5 = Crypto.md5('Привет, Мир!')
print('MD5', 'Привет, Мир!', md5)
assert(md5 == 'd2e2e8dc53cb794450113042c7556312')

-- sha1 of a string --
local sha1 = Crypto.sha1('hello world')
print('SHA1', 'hello world', sha1)
assert(sha1 == '2aae6c35c94fcfb415dbe95f408b9ce91ee846ed')
local sha1 = Crypto.sha1('Привет, Мир!')
print('SHA1', 'Привет, Мир!', sha1)
assert(sha1 == 'd67f91f1f55b432342ec2392bf1110c86291fdd3')

-- encrypt/decrypt
local salt = sha1
local s = 'СуперSecretCookie'
local enc_s = Crypto.encrypt(salt, s, true)
local dec_s = Crypto.uncrypt(salt, enc_s, true)
print('STR', s)
print('ENC', enc_s)
print('DEC', dec_s)
assert(s == dec_s)
assert(s ~= enc_s)
local enc_s = Crypto.encrypt(salt, s)
local dec_s = Crypto.uncrypt(salt, enc_s)
print('STR', s)
print('ENC', enc_s)
print('DEC', dec_s)
assert(s == dec_s)
assert(s ~= enc_s)

--
print('TEST OK')
