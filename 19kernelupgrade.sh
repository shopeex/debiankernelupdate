#!/bin/sh

set -e

SOURCE_LIST=/etc/apt/sources.list

cp -v $SOURCE_LIST $SOURCE_LIST.debsave

cat > $SOURCE_LIST.new <<EOF
# Debian Non Free
deb http://deb.debian.org/debian buster main contrib non-free
deb-src http://deb.debian.org/debian buster main contrib non-free

deb http://deb.debian.org/debian-security/ buster/updates main contrib non-free
deb-src http://deb.debian.org/debian-security/ buster/updates main contrib non-free

deb http://deb.debian.org/debian buster-updates main contrib non-free
deb-src http://deb.debian.org/debian buster-updates main contrib non-free

# Debian Backports
deb http://deb.debian.org/debian buster-backports main contrib non-free
deb-src http://deb.debian.org/debian buster-backports main contrib non-free
EOF

mv -fv $SOURCE_LIST.new $SOURCE_LIST

DEBIAN_FRONTEND=noninteractive apt update
DEBIAN_FRONTEND=noninteractive apt install -yq -o Dpkg::Options::="--force-confnew" -t buster-backports linux-image-amd64

exit 0

