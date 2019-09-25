
# needs to be root.
# dd if=/dev/zero of=./image bs=1M count=10

# just overwrite the damn header. no reason to be so obscure.

file ./image

/sbin/mkfs.ext4 -F ./image  >  /dev/null 2>&1

file ./image

