SPECVERSION = $(shell rpm -q --queryformat="%{version}\n" --specfile *.spec | head -n 1 | awk '{print $$1}' )
SPECNAME = $(shell rpm -q --queryformat="%{name}\n" --specfile *.spec | head -n 1 )

PLUGINDIR = /usr/share/munin/plugins
PLUGINS = ksm ksm_scans

install:
	test -n "$(DESTDIR)"
	
	install -d "$(DESTDIR)"

	install -d "$(DESTDIR)$(PLUGINDIR)"
	install -m 755 $(PLUGINS) $(DESTDIR)$(PLUGINDIR)	
	
dist:
	rm $(SPECNAME)-$(SPECVERSION).tar.gz || true
	rm $(SPECNAME)-$(SPECVERSION).tar || true
	git archive --format=tar --prefix="$(SPECNAME)-$(SPECVERSION)/" -o $(SPECNAME)-$(SPECVERSION).tar HEAD
	gzip $(SPECNAME)-$(SPECVERSION).tar
