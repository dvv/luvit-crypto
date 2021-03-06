#VERSION := 0.1.1
VERSION := master

all: module

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
	make INCS="`luvit --cflags | sed 's/ -Werror / /'`" -C $^
	mv build/lua-openssl/openssl.$(SOEXT) $@

build/lua-openssl:
	mkdir -p build
	wget -qct3 --no-check-certificate https://github.com/zhaozg/lua-openssl/tarball/$(VERSION) -O - | tar -xzpf - -C build
	mv build/zhaozg-lua-* $@
	# a hack to solve https://github.com/luvit/luvit/issues/49#issuecomment-3282528
	echo '#undef OPENSSL_THREADS' >>$@/src/openssl.h

clean:
	rm -fr build

test: module
	checkit ./tests/*

.PHONY: all module clean
.SILENT:
