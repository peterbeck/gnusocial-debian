GNU Social package for Debian
=============================

Licenses
--------

Is there a license incompatibility between GPL2 and Apache2 within extlib?

Updating
--------

If you need to update the package to a new version.

    git clone https://github.com/bashrc/gnusocial-debian
    git clone https://git.gnu.io/gnu/gnu-social.git
	cd gnu-social
    git checkout <hash/tag> -b <hash/tag>
    cp ..
	cp -r gnu-social/* gnusocial-debian/src/

Edit version numbers within Makefile, debian.sh and debian/changelog

Creating the package
--------------------

Run the debian.sh script to generate the package.

    sudo apt-get install build-essential lintian debconf
    cd gnusocial-debian
    ./debian.sh

The package can be tested with:

    lintian ../gnusocial_*.deb

Installation
------------

To ensure that the database gets created set the following before installing the package:

    debconf-set-selections <<<'gnusocial/domain <domain name>'
    debconf-set-selections <<<'gnusocial/admin_password string <my admin password>'
    debconf-set-selections <<<'gnusocial/mysql_password string <mysql database password>'

If you want the system to also be accessible as a .onion service:

    sudo apt-get install tor

Then to install:

    sudo dpkg -i gnusocial_*.deb

By default gnusocial will be installed to /etc/share/gnusocial and linked to /var/www/gnusocial.
