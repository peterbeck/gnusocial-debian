#!/bin/bash

SOURCE_FILE='README.md'
GNUSOCIAL_REPO='https://git.gnu.io/gnu/gnu-social.git'
GNUSOCIAL_COMMIT='771f08b3c761ff122c3fff7bdb13ec6625828018'
UPSTREAM_DIR=~/.gnu-social-package
CURR_DIR=$(pwd)

if [ $1 ]; then
    GNUSOCIAL_COMMIT=$1
fi

if [ ! -d $UPSTREAM_DIR ]; then
    git clone $GNUSOCIAL_REPO $UPSTREAM_DIR
else
    cd $UPSTREAM_DIR
    git stash
    git checkout master
    git pull
    cd $CURR_DIR
fi

cd $UPSTREAM_DIR
git stash
git checkout $GNUSOCIAL_COMMIT -b $GNUSOCIAL_COMMIT
cd $CURR_DIR

cp -r $UPSTREAM_DIR/* src/

# remove additional copyright files
cp src/COPYING LICENSE
rm src/COPYING
rm src/extlib/Michelf/License.md
rm src/extlib/gpl-2.0.txt
rm src/extlib/lgpl-2.1.txt
rm src/extlib/php-gettext/COPYING
rm src/plugins/AutoSandbox/LICENSE
rm src/plugins/FirePHP/extlib/FirePHP/lib/FirePHPCore/LICENSE
rm src/plugins/Minify/extlib/minify/LICENSE.txt
rm src/plugins/Recaptcha/LICENSE
rm src/theme/neo-quitter/LICENSE

# some insecure example
rm src/theme/neo-quitter/css/genericons/example.html

# fonts not needed
rm src/theme/neo-quitter/fonts/FontAwesome.otf
rm src/theme/neo-quitter/fonts/fontawesome-webfont.ttf

# some things replaced by debian packages
rm -rf src/extlib/php-gettext
rm -f src/extlib/Auth/OpenID.php
rm -f src/extlib/Auth/Yadis/Yadis.php
rm -f src/extlib/Michelf/Markdown.php
rm -f src/js/extlib/jquery.cookie.js
rm -f src/js/extlib/jquery.form.js
rm -f src/js/extlib/jquery.js

# update git
git add src

echo "Synced with upstream to commit $GNUSOCIAL_COMMIT"
exit 0
