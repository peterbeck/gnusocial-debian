APP=gnusocial
VERSION=0.01
RELEASE=1
ARCH_TYPE='all'
PREFIX?=/etc

all:
debug:
source:
	tar -cvf ../${APP}_${VERSION}.orig.tar ../${APP}-${VERSION} --exclude-vcs
	gzip -f9n ../${APP}_${VERSION}.orig.tar
install:
	mkdir -m 755 -p ${DESTDIR}${PREFIX}/share/${APP}
	cp -r src/* ${DESTDIR}${PREFIX}/share/${APP}
	ln -sf ${DESTDIR}${PREFIX}/share/${APP} ${DESTDIR}/var/www/gnusocial
	if [ -d "${DESTDIR}/etc/nginx" ]; then \
		install -m 644 webservers/nginx ${DESTDIR}/etc/nginx/sites-available/gnusocial; \
	fi
	if [ -d "${DESTDIR}/etc/apache2/sites-available" ]; then \
		install -m 644 webservers/apache2 ${DESTDIR}/etc/apache2/sites-available/gnusocial; \
	fi
uninstall:
	rm -rf ${PREFIX}/share/${APP}
	if [ -d "/etc/nginx" ]; then \
		rm /etc/nginx/sites-enabled/gnusocial; \
		rm /etc/nginx/sites-available/gnusocial; \
	fi
	if [ -d "/etc/apache2" ]; then \
		rm /etc/apache2/sites-available/gnusocial; \
	fi
clean:
	rm -f \#* \.#* debian/*.substvars debian/*.log
	rm -rf deb.* debian/${APP}
	rm -f ../${APP}*.deb ../${APP}*.changes ../${APP}*.asc ../${APP}*.dsc
