MODULE := crypto.luvit

GET := wget -qct3 --no-check-certificate -O -

all: build/$(MODULE)

build/$(MODULE): src/lcrypto.c
	gcc -shared -pipe -fPIC -o $@ $^ -lcrypto

src/lcrypto.c:
	mkdir -p build
  $(GET) https://github.com/mkottman/luacrypto/raw/master/src/lcrypto.c >src/lcrypto.c
  $(GET) https://github.com/mkottman/luacrypto/raw/master/src/lcrypto.h >src/lcrypto.h

clean:
	rm -fr build

test: all
	checkit ./tests/*

.PHONY: all clean test
.SILENT:
