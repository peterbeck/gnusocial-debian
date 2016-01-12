#!/bin/bash

APP=gnusocial
PREV_VERSION=0.01
VERSION=0.01
RELEASE=1
ARCH_TYPE='all'
DIR=${APP}-${VERSION}

# Update version numbers automatically - so you don't have to
sed -i 's/VERSION='${PREV_VERSION}'/VERSION='${VERSION}'/g' Makefile
sed -i 's/-'${PREV_VERSION}'.so/-'${VERSION}'.so/g' debian/*.links

make clean
make

# change the parent directory name to debian format
mv ../${APP} ../${DIR}

# Create a source archive
make source

# Build the package
dpkg-buildpackage -F

# sign files
gpg -ba ../${APP}_${VERSION}-1_${ARCH_TYPE}.deb
gpg -ba ../${APP}_${VERSION}.orig.tar.gz

# restore the parent directory name
mv ../${DIR} ../${APP}
