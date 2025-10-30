#!/bin/bash
#SBATCH --job-name=IT2TRANS
#SBATCH --partition=gpujobs  # Use GPU partition
#SBATCH --gpus-per-node=1  # Requ
#SBATCH --gres=gpu:1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=101G  # Allocate 32GB RAM
#SBATCH --output=output_%j.txt
#SBATCH --error=error_%j.txt
#SBATCH --exclusive 
#SBATCH --time=10:00:00 



source activate  itv2
# Define variables
infname="/home/f237809/Indic/en-indic-exp/devtest/all/eng_Latn-urd_Arab/test.eng_Latn"
outfname="/home/f237809/Indic/en-indic-exp/"
src_lang="eng_Latn"
tgt_lang="urd_Arab"
ckpt_dir="/home/f237809/Indic/model"

# Call the script with variables
#python transpost.py

bash joint_translate.sh \
  /home/f237809/Indic/datasets/testsets/testumc.eng_Latn \
  /home/f237809/Indic/datasets/Outputs/Actual/umc.urd_Arab \
  eng_Latn \
  urd_Arab \
  /home/f237809/Indic/en3/en-indic-exp
