#!/bin/bash
#SBATCH --job-name=FTIT2
#SBATCH --output=output-%j.out
#SBATCH --error=error-%j.err
#SBATCH --partition=gpujobs             # ✅ GPU partition
#SBATCH --nodes=1                       # 1 node is fine for 2 GPUs
#SBATCH --ntasks-per-node=1             # One task per GPU
#SBATCH --mem=0                     # Memory per node (adjust as needed)
#SBATCH --exclusive                     # No sharing



# Define variables
infname="/home/f237809/Indic/en-indic-exp/devtest/all/eng_Latn-urd_Arab/test.eng_Latn"
outfname="/home/f237809/Indic/en-indic-exp/"
src_lang="eng_Latn"
tgt_lang="urd_Arab"
ckpt_dir="/home/f237809/Indic/model"

# Call the script with variables
# bash prepare_data_joint_finetuning.sh /home/f237809/Indic/en-indic-exp/
export CUDA_VISIBLE_DEVICES=0
export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True
source activate itv2 

bash fine3.sh "/home/f237809/Indic/en2/en-indic-exp" "transformer_18_18" "/home/f237809/Indic/en-indic-preprint/fairseq_model/model/checkpoint_best.pt"
