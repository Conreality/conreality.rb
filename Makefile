BUNDLE = bundle
RAKE   = $(BUNDLE) exec rake

PACKAGE = conreality
VERSION = `cat VERSION`

SOURCES =

BINARIES =

pkg/$(PACKAGE)-$(VERSION).gem: $(SOURCES)
	$(RAKE) build

all: build

build: Rakefile pkg/$(PACKAGE)-$(VERSION).gem

check: Rakefile $(SOURCES)
	$(RAKE) spec

dist: pkg/$(PACKAGE)-$(VERSION).gem

install: Rakefile pkg/$(PACKAGE)-$(VERSION).gem
	$(RAKE) install

clean:
	@rm -f *~ *.gem pkg/*

distclean: clean

mostlyclean: clean

.PHONY: build check install clean distclean mostlyclean
