GNU Social package for Debian
=============================

Current build
-------------

Version: 1.2.0

Release: beta3

Upstream commit: 771f08b3c761ff122c3fff7bdb13ec6625828018

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

    GNUSOCIAL_DOMAIN_NAME='your domain name'
    GNUSOCIAL_ADMIN_PASSWORD='your admin user password for the gnusocial database'
    MARIADB_ROOT_PASSWORD='Your password goes here'
    sudo debconf-set-selections <<< "mariadb-server mariadb-server/root_password password $MARIADB_ROOT_PASSWORD"
    sudo debconf-set-selections <<< "mariadb-server mariadb-server/root_password_again password $MARIADB_ROOT_PASSWORD"
    sudo debconf-set-selections <<< "gnusocial gnusocial/domain string $GNUSOCIAL_DOMAIN_NAME"
    sudo debconf-set-selections <<< "gnusocial gnusocial/admin_password password $GNUSOCIAL_ADMIN_PASSWORD"

Install your preferred web server:

    sudo apt-get install nginx

or

    sudo apt-get install apache2

Then to install:

    sudo apt-get install eatmydata libjbig0 libterm-readkey-perl libtiff5 libaio1 mariadb-server-10.0 php-gettext php-openid php5 php5-cli php5-curl php5-gd php-db php-mail php-mail-mimedecode php-http-request2 php5-fpm php-auth-sasl php-net-ldap2 php-net-smtp php-net-socket php-net-url2 php-pear php-validate php5-gmp php5-intl php5-json php5-mysql php5-stomp libmarkdown-php libjs-jquery-cookie libjs-jquery-form libjs-jquery-ui libjs-jquery fonts-font-awesome git curl php-xml-parser libcurl3 php-mail-mime libgd3 libjpeg62-turbo libxpm4
    sudo eatmydata dpkg -i ../gnusocial_*.deb

By default gnusocial will be installed to **/etc/share/gnusocial** and linked to **/var/www/gnusocial**.

Web host examples will be created within **/etc/apache2/sites-available** or **/etc/nginx/sites-available**, but they're not enabled. You can use that as a guide to how to integrate gnusocial with your system.

To obtain a Let's Encrypt certificate for your domain name:

    sudo su
    cd ~/
    git clone https://github.com/letsencrypt/letsencrypt
    systemctl stop nginx/apache2
	cd ~/letsencrypt
    ./letsencrypt-auto certonly --server https://acme-v01.api.letsencrypt.org/directory --standalone -d <domain name> --renew-by-default --agree-tos --email <your email address>
    systemctl start nginx/apache2
    exit

If you also want an onion address:

    sudo su
    apt-get install tor
    echo 'HiddenServiceDir /var/lib/tor/hidden_service_gnusocial' >> /etc/tor/torrc
    echo 'HiddenServicePort 80 127.0.0.1:8087' >> /etc/tor/torrc
    systemctl stop tor
    systemctl start tor
    echo "GNU Social onion address: $(cat /var/lib/tor/hidden_service_gnusocial/hostname)"
    exit

Then if you're using nginx append this to the end of to your */etc/nginx/sites-available/gnusocial* file:

    server {
        listen 127.0.0.1:8087 default_server;
        server_name gnusocial.onion;
        root /var/www/gnusocial;
        index index.php index.html index.htm;
        access_log off;
        location ~* \.php$ {
            try_files $uri $uri/ /index.php;
            fastcgi_split_path_info ^(.+\.php)(/.+)$;
            fastcgi_pass unix:/var/run/php5-fpm.sock;
            include fastcgi_params;
            fastcgi_index index.php;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
            fastcgi_read_timeout 300;
        }
        add_header X-Frame-Options DENY;
        add_header X-Content-Type-Options nosniff;
        location / {
            rewrite ^(.*)$ /index.php?p=$1 last;
            break;
        }
        location ~* ^/(.*)\.(ico|css|js|gif|png|jpg|bmp|JPG|jpeg)$ {
            root /var/www/gnusocial;
            rewrite ^/(.*)$ /$1 break;
            access_log off;
            expires max;
        }
        client_max_body_size      15m;
        error_log off;
    }

To enable your site:

    sudo ln -s /etc/nginx/sites-available/gnusocial /etc/nginx/sites-enabled/
    sudo rm /etc/nginx/sites-enabled/default
    sudo systemctl restart nginx
    sudo systemctl restart php5-fpm

or for Apache:

    sudo a2ensite gnusocial
    sudo systemctl restart apache2

Then in a browser navigate to your domain name or your onion address in a Tor compatible browser.

To set up your GNU Social site:

 * Set a name for the site
 * Server SSL: enable
 * Hostname: localhost
 * Type: MySql/MariaDB
 * Name: gnusocial
 * DB username: root
 * DB Password; *[MariaDB root password]*
 * Administrator nickname: *[your username]*
 * Administrator password: *[your admin user password for the gnusocial database]*
 * Subscribe to announcements: ticked
 * Site profile: Community

When the install is complete you will see a lot of warnings but just ignore those and navigate to your domain name (or onion address) and you can then complete the configuration via the *Admin* section on the header bar.
