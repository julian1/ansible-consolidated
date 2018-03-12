#!/bin/bash

# photos
aws s3 sync ./smaller  s3://s3.julian1.io/rx100/smaller --acl public-read

# video
# aws s3 cp ./100ANV01/MAH01872.MP4 s3://s3.julian1.io/rx100/100ANV01/MAH01872.MP4 --acl public-read


