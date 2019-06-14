
set -x

export PATH="$HOME/.local/bin:$PATH"

# aws s3 sync Pictures/phone/a20      s3://julian1-private/Pictures/phone/a20
# aws s3 sync drive/Pictures/phone/xz1 s3://julian1-private/Pictures/phone/xz1 

#aws s3 sync drive/Pictures/phone s3://julian1-private/Pictures/phone 
# aws s3 sync drive/Pictures/michaels s3://julian1-private/Pictures/michaels

aws s3 sync drive/Pictures    s3://julian1-private/Pictures



