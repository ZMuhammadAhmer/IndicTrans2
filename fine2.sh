#!/bin/bash

echo `date`
exp_dir=$1
model_arch=${2:-"transformer_18_18"}
pretrained_ckpt=$3

fairseq-train $exp_dir/final_bin \
  --max-source-positions=210 \
  --max-target-positions=210 \
  --max-update=150000 \
  --save-interval=1 \
  --arch=$model_arch \
  --criterion=label_smoothed_cross_entropy \
  --source-lang=SRC \
  --lr-scheduler=inverse_sqrt \
  --target-lang=TGT \
  --label-smoothing=0.1 \
  --optimizer adam \
  --adam-betas "(0.9, 0.98)" \
  --clip-norm 1.0 \
  --warmup-init-lr 1e-07 \
  --warmup-updates 6000 \
  --dropout 0.3 \
  --save-dir $exp_dir/model \
  --keep-last-epochs 5 \
  --patience 2 \
  --skip-invalid-size-inputs-valid-test \
  --fp16 \
  --memory-efficient-fp16 \
  --user-dir model_configs \
  --update-freq=1 \
  --distributed-world-size 1 \
  --max-tokens 256 \
  --lr 7e-5 \
  --restore-file $pretrained_ckpt \
  --reset-lr-scheduler \
  --reset-meters \
  --reset-dataloader \
  --reset-optimizer \
  --eval-bleu \
 --eval-bleu-args "{\"beam\": 4, \"lenpen\": 1.0, \"max_len_a\": 1.2, \"max_len_b\": 10}" \
 --eval-bleu-detok moses \
 --eval-bleu-remove-bpe sentencepiece \
 --eval-bleu-print-samples \
 --best-checkpoint-metric bleu \
 --validate-interval=1
