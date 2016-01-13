GNU Social package for Debian
=============================

Licenses
--------

Is there a license incompatibility between GPL2 and Apache2 within extlib?

Installation
------------

To ensure that the database gets created set the following before installing the package:

    export GNUSOCIAL_ADMIN_PASSWORD=<admin password for gnusocial database>
    export MYSQL_ROOT_PASSWORD=<root password for MariaDB/MySql>

By default gnusocial will be installed to /etc/share/gnusocial and linked to /var/www/gnusocial
