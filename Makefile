APP=gnusocial
VERSION=1.2.x
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
	cp -r webservers ${DESTDIR}${PREFIX}/share/${APP}
uninstall:
	rm -rf ${PREFIX}/share/${APP}
	if [ -d "/etc/nginx" ]; then \
		rm -f /etc/nginx/sites-enabled/gnusocial; \
		rm /etc/nginx/sites-available/gnusocial; \
	fi
	if [ -d "/etc/apache2" ]; then \
		a2dissite; \
		rm /etc/apache2/sites-available/gnusocial; \
	fi
	if [ -d "/var/www/gnusocial" ]; then \
		rm -rf /var/www/gnusocial; \
	fi
clean:
	rm -f \#* \.#* debian/*.substvars debian/*.log
	rm -rf deb.* debian/${APP}
	rm -f ../${APP}*.deb ../${APP}*.changes ../${APP}*.asc ../${APP}*.dsc
