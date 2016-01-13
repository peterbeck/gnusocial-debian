GNU Social package for Debian
=============================

Licenses
--------

Is there a license incompatibility between GPL2 and Apache2 within extlib?

Updating
--------

If you need to update the package to a new version.

    got clone https://github.com/bashrc/gnusocial-debian
    git clone https://git.gnu.io/gnu/gnu-social.git
	cd gnu-social
    git checkout <hash/tag> -b <hash/tag>
    cp ..
	cp -r gnu-social/* gnusocial-debian/src/

Edit version numbers within Makefile, debian.sh and debian/changelog

Creating the package
--------------------

Run the debian.sh script to generate the package.

    cd gnusocial-debian
    ./debian.sh

Installation
------------

To ensure that the database gets created set the following before installing the package:

    export GNUSOCIAL_ADMIN_PASSWORD=<admin password for gnusocial database>
    export MYSQL_ROOT_PASSWORD=<root password for MariaDB/MySql>

By default gnusocial will be installed to /etc/share/gnusocial and linked to /var/www/gnusocial
