#!/bin/bash
# deployed by ansible!

set -e

if [ -z $1 ] || [ -z $2 ] ; then
  echo "usage: $0 <src.tgz.enc> <restoredir or ./> <extra tar args>"
  exit 123
fi


src=$1
restoredir=$2
stripcomponents=$3
# remaining args - feed to tar. useful for --strip-components
args=${@:3:999}


if ! [ -f $src ]; then
  echo "src file '$src' does not exist!"
  exit 123
fi

# easy to type ./ dst if needed. no need for default
if ! [ -d $restoredir ]; then
  echo "restore dir '$restoredir' does not exist!"
  exit 123
fi


# TODO - rather than hardcoding this...
# just use args=${@:3:999} trick and pass through
#if [ -z $stripcomponents ]; then
#  stripcomponents=0
#fi
#   --strip-components $stripcomponents \


# read pass
read -s -p "pass: " pass ; echo

cipher=-aes-256-cbc

openssl enc \
  -d "$cipher" \
  -pass "pass:$pass" \
  -in $src \
| tar \
  -xz \
  $args \
  -C $restoredir


