SRC := $(shell find src -name "*.d") $(shell find libdparse/src -name "*.d")
INCLUDE_PATHS := -Ilibdparse/src
DMD_FLAGS := -g -w $(INCLUDE_PATHS)
LDC_FLAGS := -g -w -oq $(INCLUDE_PATHS)

.PHONY: dmd ldc test

dmd: bin/dfmt

ldc: $(SRC)
	ldc2 $(LDC_FLAGS) $(SRC) -ofbin/dfmt
	-rm -f *.o

test:
	dmd $(DMD_FLAGS) -unittest $(SRC) -ofbin/dfmt
	cd tests && ./test.sh

bin/dfmt: $(SRC)
	dmd $(DMD_FLAGS) $(SRC) -ofbin/dfmt
