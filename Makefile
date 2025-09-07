PREFIX := /usr
BINDIR := $(PREFIX)/bin
LIBDIR := $(PREFIX) # bunu library'ye linkle

SDB := tools/sdb

all: requirements install

requirements: sdb
	bash missing.sh

sdb:
	$(MAKE) -C $(SDB)
	install -m 755 $(SDB)/src/sdb $(BINDIR)/sdb

clean:
	$(MAKE) -C $(SDB) clean

install:
	mkdir -p $(BINDIR)
	install -m 755 langush.sh $(BINDIR)/langush

uninstall:
	rm -vf $(BINDIR)/langush

.PHONY: all requirements sdb clean install uninstall
