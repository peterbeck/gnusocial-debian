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
	mkdir -m 755 -p ${DESTDIR}${PREFIX}/share/man/man1
	install -m 644 man/${APP}.1.gz ${DESTDIR}${PREFIX}/share/man/man1
	ln -sf ${DESTDIR}${PREFIX}/share/${APP} ${DESTDIR}/var/www/gnusocial
	if [ -d "${DESTDIR}/etc/nginx" ]; then \
		install -m 644 webservers/nginx ${DESTDIR}/etc/nginx/sites-available/gnusocial; \
		ln -s ${DESTDIR}/etc/nginx/sites-available/gnusocial ${DESTDIR}/etc/nginx/sites-enabled/; \
	fi
	if [ -d "${DESTDIR}/etc/apache2" ]; then \
		install -m 644 webservers/apache2 ${DESTDIR}/etc/apache2/sites-available/gnusocial; \
		a2ensite gnusocial
	fi
uninstall:
	rm -f ${PREFIX}/share/man/man1/${APP}.1.gz
	rm -rf ${PREFIX}/share/${APP}
	if [ -d "/etc/nginx" ]; then \
		rm /etc/nginx/sites-enabled/gnusocial; \
		rm /etc/nginx/sites-available/gnusocial; \
	fi
	if [ -d "/etc/apache2" ]; then \
		a2dissite gnusocial
		rm /etc/apache2/sites-available/gnusocial; \
	fi
clean:
	rm -f \#* \.#* debian/*.substvars debian/*.log
	rm -rf deb.* debian/${APP}
	rm -f ../${APP}*.deb ../${APP}*.changes ../${APP}*.asc ../${APP}*.dsc
