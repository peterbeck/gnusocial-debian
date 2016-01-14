GNU Social package for Debian
=============================

Current build
-------------

Version: 1.2.0
Release: beta3
Upstream commit: 67801a556610f89a60106c0074c42947967f3adf

Updating
--------

If you need to update the package to a new version then edit the above version/commit then run:

    make sync

Also edit debian/changelog with the latest version at the top. The email address within the changelog must exactly correspond to your gpg key.

Creating the package
--------------------

Run the debian.sh script to generate the package.

    sudo apt-get install build-essential lintian debconf
    git clone https://github.com/bashrc/gnusocial-debian
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

And if you want your site to be _only_ accessible as an onion service:

    debconf-set-selections <<<'gnusocial/domain gnusocial.onion'

Then to install:

    sudo dpkg -i gnusocial_*.deb

By default gnusocial will be installed to **/etc/share/gnusocial** and linked to **/var/www/gnusocial**.

Web host examples will be created within **/etc/apache2/sites-available** or **/etc/nginx/sites-available**, but they're not enabled. You can use that as a guide to how to integrate gnusocial with your system.
