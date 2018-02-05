#!/usr/bin/env sh
# Compute the mean image from the imagenet training lmdb
# N.B. this is available in db/train_lmdb

NAME=horda-transport-caffe-model

EXAMPLE=examples/$NAME
OUT=examples/$NAME/data
DATA=examples/$NAME/db/train_lmdb
TOOLS=build/tools

$TOOLS/compute_image_mean $EXAMPLE/db/train_lmdb \
  $OUT/mean.binaryproto

echo "Done."
