# Set this variable to point to folder share of your SMACK installation
INSTALL_SHARE = /usr/local/share

CC = clang
LD = llvm-link
SMACK = llvm2bpl.py
INC = $(INSTALL_SHARE)/smack/include
CFLAGS = -c -MD -Wall -emit-llvm -O0 -g -I$(INC)

SOURCES := $(wildcard *.c)
OBJS = $(subst .c,.bc,$(SOURCES))
SMKS = $(subst .c,.bpl,$(SOURCES))

.PHONY: clean all

all: $(SMKS)

smack.bc: $(INSTALL_SHARE)/smack/lib/smack.c $(INC)/smack.h
	$(CC) $(CFLAGS) $< -o smack.bc

%.bc: %.c smack.bc
	$(CC) $(CFLAGS) $< -o $@
	$(LD) -o $@ $@ smack.bc

-include $(OBJS:.bc=.d)

%.bpl: %.bc
	$(SMACK) $< -o $@

clean:
	rm -f *.bc *.bpl *.d

