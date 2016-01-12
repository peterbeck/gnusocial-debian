#!/bin/bash

APP=gnusocial
PREV_VERSION=0.01
VERSION=0.01
RELEASE=1
ARCH_TYPE='all'
DIR=${APP}-${VERSION}
export DH_ALWAYS_EXCLUDE=.git

# Update version numbers automatically - so you don't have to
sed -i 's/VERSION='${PREV_VERSION}'/VERSION='${VERSION}'/g' Makefile
sed -i 's/-'${PREV_VERSION}'.so/-'${VERSION}'.so/g' debian/*.links

make clean
make
if [ ! "$?" = "0" ]; then
	exit 1
fi

# change the parent directory name to debian format
mv ../${APP}-debian ../${DIR}

# Create a source archive
make source
if [ ! "$?" = "0" ]; then
    mv ../${DIR} ../${APP}-debian
	exit 2
fi

# Build the package
dpkg-buildpackage -i -F
if [ ! "$?" = "0" ]; then
    mv ../${DIR} ../${APP}-debian
	exit 3
fi

# sign files
#gpg -ba ../${APP}_${VERSION}-1_${ARCH_TYPE}.deb
#gpg -ba ../${APP}_${VERSION}.orig.tar.gz

# restore the parent directory name
mv ../${DIR} ../${APP}-debian
