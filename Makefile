APP=gnusocial
VERSION='1.2.0'
RELEASE='beta3'
ARCH_TYPE='all'
PREFIX?=/etc

all:
debug:
sync:
	./upstream-to-debian.sh
source:
	tar -cvf ../${APP}_${VERSION}.orig.tar ../${APP}-${VERSION} --exclude-vcs
	gzip -f9n ../${APP}_${VERSION}.orig.tar
install:
	mkdir -m 755 -p ${DESTDIR}${PREFIX}/share/${APP}
	cp -r src/* ${DESTDIR}${PREFIX}/share/${APP}
	cp -r webservers ${DESTDIR}${PREFIX}/share/${APP}
uninstall:
	rm -rf ${PREFIX}/share/${APP}
	if [ -L /etc/nginx/sites-enabled/${APP} ]; then \
		rm -f /etc/nginx/sites-enabled/${APP}; \
	fi
	if [ -f /etc/nginx/sites-available/${APP} ]; then \
		rm /etc/nginx/sites-available/${APP}; \
	fi
	if [ -d /etc/apache2 ]; then \
		a2dissite ${APP}; \
		rm /etc/apache2/sites-available/${APP}; \
	fi
	if [ -d /var/www/${APP} ]; then \
		rm /var/www/${APP}; \
	fi
clean:
	rm -f \#* \.#* debian/*.substvars debian/*.log debian/gnusocial*
	rm -rf deb.* debian/${APP}
	rm -f ../${APP}*.deb ../${APP}*.changes ../${APP}*.asc ../${APP}*.dsc
