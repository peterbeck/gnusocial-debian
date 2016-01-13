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

cp src/etc/share/gnusocial/COPYING COPYING
rm src/etc/share/gnusocial/COPYING
rm src/extra-license-file etc/share/gnusocial/extlib/Michelf/License.md
rm src/extra-license-file etc/share/gnusocial/extlib/gpl-2.0.txt
rm src/extra-license-file etc/share/gnusocial/extlib/lgpl-2.1.txt
rm src/extra-license-file etc/share/gnusocial/extlib/php-gettext/COPYING
rm src/extra-license-file etc/share/gnusocial/plugins/AutoSandbox/LICENSE
rm src/extra-license-file etc/share/gnusocial/plugins/FirePHP/extlib/FirePHP/lib/FirePHPCore/LICENSE
rm src/extra-license-file etc/share/gnusocial/plugins/Minify/extlib/minify/LICENSE.txt
rm src/extra-license-file etc/share/gnusocial/plugins/Recaptcha/LICENSE
rm src/extra-license-file etc/share/gnusocial/theme/neo-quitter/LICENSE
rm src/theme/neo-quitter/fonts/FontAwesome.otf
rm src/theme/neo-quitter/fonts/fontawesome-webfont.ttf
git add src

echo "Synced with upstream to commit $GNUSOCIAL_COMMIT"
exit 0
