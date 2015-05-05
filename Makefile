.PHONY: all build default release schmunk

default: build

all: neam schmunk42

neam:
	$(MAKE) -f Makefile-neam $@ ; \

schmunk42:
	$(MAKE) -f Makefile-schmunk42 $@ ; \
