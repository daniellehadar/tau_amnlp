#!/bin/bash

# Copyright (c) Facebook, Inc. and its affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

PY_BIN_ROOT=

# PyPI dependency
${PY_BIN_ROOT}pip install sentencepiece sacremoses

# Get data
if [ ! -d "data" ]; then
  mkdir data
fi

if [ ! -f "data/ja-en.tgz" ]; then
  wget https://wit3.fbk.eu/archive/2017-01-trnted/texts/ja/en/ja-en.tgz -P data
  tar xvf data/ja-en.tgz -C data
fi
${PY_BIN_ROOT}python get_bitext1.py --byte-vocab 
#for VOCAB_SIZE in 2048 4096; do
 #${PY_BIN_ROOT}python get_bitext1.py --byte-vocab ${VOCAB_SIZE} 
#done
rm -r data/ja-en data/ja-en.tgz

# Generate binary dataset


${PY_BIN_ROOT}python preprocess.py --source-lang ja --target-lang en --destdir data/bin_bytes --joined-dictionary \
  --workers 1 --trainpref data/train.bytes --validpref data/valid.bytes \
  --testpref data/test.bytes


#for VOCAB_SIZE in 2048 4096; do
 # for TYPE in bbpe bpe; do
  #  ${PY_BIN_ROOT}python preprocess.py --source-lang de --target-lang en --destdir "data_de_en/bin_${TYPE}${VOCAB_SIZE}" \
   #   --joined-dictionary --workers "$(nproc)" --trainpref "data_de_en/train.moses.${TYPE}${VOCAB_SIZE}" \
    #  --validpref "data_de_en/valid.moses.${TYPE}${VOCAB_SIZE}" --testpref "data_de_en/test.moses.${TYPE}${VOCAB_SIZE}"
 # done
#done
