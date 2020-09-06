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

if [ ! -f "data/fr-en.tgz" ]; then
  wget https://wit3.fbk.eu/archive/2017-01-trnted/texts/fr/en/fr-en.tgz -P data
  tar xvf data/fr-en.tgz -C data
fi
${PY_BIN_ROOT}python get_bitext.py --byte-vocab 
#for VOCAB_SIZE in 2048 4096; do
 #${PY_BIN_ROOT}python get_bitext.py --byte-vocab ${VOCAB_SIZE} 
#done
rm -r data/fr-en data/fr-en.tgz

# Generate binary dataset


${PY_BIN_ROOT}python preprocess.py --source-lang fr --target-lang en --destdir data/bin_bytes --joined-dictionary \
  --workers "$(nproc)" --trainpref data/train --validpref data/valid \
  --testpref data/test


#for VOCAB_SIZE in 2048 4096; do
 # for TYPE in bbpe bpe; do
  #  ${PY_BIN_ROOT}python preprocess.py --source-lang fr --target-lang en --destdir "data/bin_${TYPE}${VOCAB_SIZE}" \
   #   --joined-dictionary --workers "$(nproc)" --trainpref "data/train.moses.${TYPE}${VOCAB_SIZE}" \
    #  --validpref "data/valid.moses.${TYPE}${VOCAB_SIZE}" --testpref "data/test.moses.${TYPE}${VOCAB_SIZE}"
 # done
#done
