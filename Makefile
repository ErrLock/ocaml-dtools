# Copyright 2003-2007 Savonet team

SRC=src
PROGNAME=ocaml-dtools
DISTFILES = bootstrap CHANGES configure configure.ac \
            COPYING Makefile README m4/*.m4 \
            src/OCamlMakefile src/*Makefile.in src/META.in src/*.ml src/*.mli \
            doc/html

all:
	$(MAKE) -C $(SRC)

clean:
	$(MAKE) -C $(SRC) clean

install:
	$(MAKE) -C $(SRC) install

uninstall:
	$(MAKE) -C $(SRC) uninstall

update:
	$(MAKE) -C $(SRC) update

distclean: clean
	rm -rf autom4te.cache config.log config.status
	rm -rf doc/html
	rm -f src/META src/Makefile

doc:
	$(MAKE) -C src htdoc
	mkdir -p doc
	rm -rf doc/html
	mv src/doc/dtools/html doc
	rm -rf src/doc

dist: doc
	VERSION="$(shell grep 'AC_INIT' configure.ac)"; \
		VERSION=`echo "$$VERSION" | sed -e 's/AC_INIT([^,]*, \([^,]*\), .*)/\1/'`; \
		mkdir $(PROGNAME)-$$VERSION; \
		cp -r --parents $(DISTFILES) $(PROGNAME)-$$VERSION; \
		tar zcvf $(PROGNAME)-$$VERSION.tar.gz $(PROGNAME)-$$VERSION; \
		rm -rf $(PROGNAME)-$$VERSION

.PHONY: doc

