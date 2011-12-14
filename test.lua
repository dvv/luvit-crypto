#!/usr/bin/env luvit
local FS = require("fs")
local Crypto = require ("crypto")

-- check module --
assert (not _G.openssl)
assert (Crypto.get_cipher)

-- asynchrounous md5 from file --
local md5 = Crypto.get_digest ("md5"):init ()
local stream = FS.create_read_stream ("/bin/ls")
stream:on ("data", function (data) md5:update (data) end)
stream:on ("end", function () print("</bin/ls", Crypto.to_hex(md5:final ())) end)

-- from string --
local md5 = Crypto.get_digest ("md5"):init ()
md5:update ("hello world")
print ("hello world", Crypto.to_hex (md5:final ()))
