#!/bin/bash
#SBATCH --job-name=CPUTransIT2
#SBATCH --partition=cpujobs  # Use GPU partition
#SBATCH --ntasks-per-node=1
#SBATCH --mem=101G  # Allocate 32GB RAM
#SBATCH --output=output_%j.txt
#SBATCH --error=error_%j.txt
#SBATCH --exclusive 
#SBATCH --time=10:00:00 

source activate itv2  # Ensure the correct Conda environment is activated


bash joint_translate.sh \
  /home/f237809/Indic/datasets/testsets/act.eng_Latn \
  /home/f237809/Indic/datasets/Outputs/Trans-TransTanz/actual.urd_Arab \
  eng_Latn \
  urd_Arab \
  /home/f237809/Indic/en2/en-indic-exp
