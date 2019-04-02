#!/bin/bash -x

# should rename backup-upload.sh
# TODO - include md5sum in header
# https://aws.amazon.com/premiumsupport/knowledge-center/data-integrity-s3/
# issue is that need to install aws, easier to use web ui
review
exit

target="$HOSTNAME-$(date '+%F-%H-%M').me.tgz.enc"
bucket=""
if [ -z $bucket ]; then
  echo "set the bucket!"
  exit
else
  aws s3 cp ./me.tgz.enc "s3://$bucket/$target"
fi
