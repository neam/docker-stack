.PHONY: all build default release schmunk

default: build

all: neam

neam:
	$(MAKE) -f Makefile-neam $@ ; \
