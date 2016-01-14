#!/bin/bash

SOURCE_FILE='README.md'
GNUSOCIAL_COMMIT=$(cat $SOURCE_FILE | grep 'Upstream commit:' | head -n 1 | awk -F ':' '{print $2}' | sed -e 's/^[ \t]*//')

if [ $1 ]; then
    GNUSOCIAL_COMMIT=$1
fi

if [ ! -d gnu-social ]; then
    git clone https://git.gnu.io/gnu/gnu-social.git
else
    cd gnu-social
    git stash
    git checkout master
    git pull
    cd ..
fi

cd gnu-social
git stash
git checkout $GNUSOCIAL_COMMIT -b $GNUSOCIAL_COMMIT
cd ..

cp -r gnu-social/* src/

# remove additional copyright files
cp src/COPYING COPYING
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
