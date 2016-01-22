GNU Social package for Debian
=============================

Current build
-------------

Version: 1.2.0

Release: beta3

Upstream commit: 67801a556610f89a60106c0074c42947967f3adf

Updating
--------

If you need to update the package to a new version then edit the above version/commit and debian/changelog then run:

    ./debian.sh

Creating the package
--------------------

Run the debian.sh script to generate the package.

    sudo apt-get install build-essential lintian python-software-properties debconf-utils software-properties-common
    git clone https://github.com/bashrc/gnusocial-debian
    cd gnusocial-debian
    ./debian.sh

Installation
------------

To ensure that the database gets created set the following before installing the package:

    debconf-set-selections <<<'gnusocial gnusocial/domain string <domain name>'
    debconf-set-selections <<<'gnusocial gnusocial/admin_password string <my admin password>'
    debconf-set-selections <<<'gnusocial gnusocial/mysql_password string <mysql database password>'

If you want the system to also be accessible as a .onion service:

    sudo apt-get install tor

And if you want your site to be _only_ accessible as an onion service:

    debconf-set-selections <<<'gnusocial gnusocial/domain string gnusocial.onion'
    debconf-set-selections <<<'gnusocial gnusocial/admin_password string <my admin password>'
    debconf-set-selections <<<'gnusocial gnusocial/mysql_password string <mariaDB root user password>'

Install your preferred web server:

    sudo apt-get install nginx

or

    sudo apt-get install apache2

Then to install:

    sudo apt-get install libjbig0 libterm-readkey-perl libtiff5 libaio1 mariadb-server-10.0 php-gettext php-openid php5 php5-cli php5-curl php5-gd php-db php-mail php-mail-mimedecode php-http-request2 php5-fpm php-auth-sasl php-net-ldap2 php-net-smtp php-net-socket php-net-url2 php-pear php-validate php5-gmp php5-intl php5-json php5-mysql php5-stomp libmarkdown-php libjs-jquery-cookie libjs-jquery-form libjs-jquery-ui libjs-jquery fonts-font-awesome git curl php-xml-parser libcurl3 php-mail-mime libgd3 libjpeg62-turbo libxpm4

If this is the first time that you have installed MariaDB then set the root password to be the same as you gave for *gnusocial/mysql_password* above. Then you can install gnusocial:

    sudo dpkg -i ../gnusocial_*.deb

By default gnusocial will be installed to **/etc/share/gnusocial** and linked to **/var/www/gnusocial**.

Web host examples will be created within **/etc/apache2/sites-available** or **/etc/nginx/sites-available**, but they're not enabled. You can use that as a guide to how to integrate gnusocial with your system.
