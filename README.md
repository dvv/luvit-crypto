Crypto API for [Luvit](https://github.com/luvit/luvit)
====

[![Build Status](https://secure.travis-ci.org/luvit/crypto.png)](http://travis-ci.org/luvit/crypto)

A simple wrapper exposing OpenSSL interface via [Lua-OpenSSL](https://github.com/zhaozg/lua-openssl).

Example
-------

    local Crypto = require('crypto')
    local sha1 = Crypto.sha1('Привет, Мир!', true)
    print('SHA1', 'Привет, Мир!', sha1)
    assert(sha1 == 'd67f91f1f55b432342ec2392bf1110c86291fdd3')

See [test](crypto/tests/smoke.lua) for more.

License
-------

[MIT](crypto/license.txt)
