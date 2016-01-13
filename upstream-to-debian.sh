#!/bin/bash

GNUSOCIAL_COMMIT='67801a556610f89a60106c0074c42947967f3adf'

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
rm src/theme/neo-quitter/fonts/FontAwesome.otf
rm src/theme/neo-quitter/fonts/fontawesome-webfont.ttf
git add src

echo "Synced with upstream to commit $GNUSOCIAL_COMMIT"
exit 0
