#VERSION := 0.1.1
VERSION := master

ROOT    := $(shell pwd)
PATH    := $(ROOT)/.luvit:$(PATH)

all: module

test: module
	#luvit test
	./test

OS ?= $(shell uname)
ifeq ($(OS),Darwin)
SOEXT := dylib
else ifeq ($(OS),Windows)
SOEXT := dll
else
LDFLAGS += -luuid -lrt -lpthread -ldl
SOEXT := so
endif

module: build/lua-openssl/openssl.luvit

build/lua-openssl/openssl.luvit: build/lua-openssl
	make INCS="`luvit-config --cflags | sed 's/ -Werror / /'`" -C $^
	mv build/lua-openssl/openssl.$(SOEXT) $@

build/lua-openssl:
	mkdir -p build
	wget -qct3 --no-check-certificate https://github.com/zhaozg/lua-openssl/tarball/$(VERSION) -O - | tar -xzpf - -C build
	mv build/zhaozg-lua-* $@

clean:
	rm -fr build

.PHONY: all module clean
#.SILENT:
