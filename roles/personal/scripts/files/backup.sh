#!/bin/bash
# deployed by ansible!

set -e

if [ -z $1 ] || [ -z $2 ] ; then
  echo "usage: $0 <src dir> <dst dir>"
  exit 123
fi

parentdir=$(dirname $1)
dir=$(basename $1)

if ! [ -d "$parentdir/$dir" ]; then
  echo "src dir does not exist!"
  exit 123 ;
fi

date="$(date --rfc-3339=date)"
target="$2/$dir-$date.tgz.enc"

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

tar \
  --exclude $target \
  -cz \
  -C $parentdir \
  $dir \
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






