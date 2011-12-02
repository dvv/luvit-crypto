#VERSION := 0.1.1
VERSION := master

all: crypto

crypto: build/lua-openssl/openssl.so

build/lua-openssl/openssl.so: build/lua-openssl
	make INCS=-I$(LUA_DIR) -C $^

build/lua-openssl:
	mkdir -p build
	wget http://github.com/zhaozg/lua-openssl/tarball/$(VERSION) -O - | tar -xzpf - -C build
	mv build/zhaozg-lua-* $@

.PHONY: all crypto
.SILENT:
