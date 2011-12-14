#VERSION := 0.1.1
VERSION := master

all: module

OS ?= $(shell uname)
ifeq ($(OS),Darwin)
SOEXT := dylib
#LIB_OPTION=-bundle -undefined dynamic_lookup
else ifeq ($(OS),Windows)
SOEXT := dll
else
LDFLAGS += -luuid -lrt -lpthread -ldl
SOEXT := so
endif
OPENSSL_LIBS=$(shell pkg-config openssl --libs)

module: modules/crypto/openssl.luvit build/lua-openssl/openssl.luvit

modules/crypto/openssl.luvit: build/lua-openssl/openssl.luvit
	mkdir -p modules/crypto
	cp build/lua-openssl/openssl.luvit $@

build/lua-openssl/openssl.luvit: build/lua-openssl
	mv build/lua-openssl/makefile build/lua-openssl/makefile.orig
	sed -e 's,\.so,\.${SOEXT},g' -e 's,-l.*$$,,' build/lua-openssl/makefile.orig > build/lua-openssl/Makefile
	make CC="${CC}" INCS=-I$(LUA_DIR) LIB_OPTION="$(LIB_OPTION) $(OPENSSL_LIBS)" -C $^
	mv build/lua-openssl/openssl.$(SOEXT) $@

build/lua-openssl:
	mkdir -p build
	wget -ct3 --no-check-certificate https://github.com/zhaozg/lua-openssl/tarball/$(VERSION) -O - | tar -xzpvf - -C build
	mv build/zhaozg-lua-* $@

clean:
	rm -fr build
	rm -fr modules/build/openssl.luvit

.PHONY: all module clean
#.SILENT:
