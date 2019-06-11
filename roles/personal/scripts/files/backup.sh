#!/bin/bash
# deployed by ansible!

set -e

if [ -z $1 ] || [ -z $2 ] ; then
  echo "usage: $0 <src dir> <dst dir> <extra tar args>"
  exit 123
fi

# get remaining args - which we feed through to tar. useful for exclude
# eg. backup.sh src dst --exclude '/proc' --exclude '/sys' --exclude '/run' --exclude '/dev' --exclude '/tmp' --exclude '/mnt'
# or just use s mount --bind / /mnt/test/  which remounts and will exclude this stuff.

args=${@:3:999}


parentsrc=$(dirname $1)
src=$(basename $1)

if ! [ -d "$parentsrc/$src" ]; then
  echo "src dir does not exist!"
  exit 123 ;
fi

date="$(date --rfc-3339=date)"

# https://stackoverflow.com/questions/4638983/remove-unnecessary-slashes-from-a-given-path-with-bash
# fully qualify path and remove duplicate // which confuses tar --exclude $target
target=$(readlink -m "$2/$src-$date.tgz.enc" )


echo "target: $target"

if [ -f $target ]; then
  echo "dst target '$target' already exists!"
  exit 123
fi

####

read -s -p "pass: "   pass ; echo
read -s -p "again: "  pass2 ; echo

if [ "$pass" != "$pass2" ]; then
  echo "not the same!"
  exit 123
fi

####

cipher=-aes-256-cbc

# we don't want to exclude /mnt if we're backing up something in /mnt/drive etc.


tar \
  --exclude $target \
  $args \
  -czp \
  -C $parentsrc \
  $src \
| openssl enc \
  -e "$cipher" \
  -pass "pass:$pass" \
  -out $target \

#-in stdin   \

# aws checksum doesn't work for large files...
# use s3md5 and verify locally instead.

# x-amz-meta-md5chksum
# note md5 -binary is different from md5sum
# hash=$( openssl md5 -binary $target | base64 )
# echo $hash > "$target.md5"

#hash=$( md5sum $target )
#echo $hash > "$target.md5"


