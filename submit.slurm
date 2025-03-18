#!/bin/bash
#SBATCH --job-name=sft_r1_demo
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:1
#SBATCH -p singlegpuB
#SBATCH --output=./log/%x_%j.out
#SBATCH --error=./log/%x_%j.err

module load anaconda3 cuda-12.4
source ~/.bashrc

# activate your environment
source activate alignment

HF_DIR='/home/xxx/hf_cache'
export HF_HOME=${HF_DIR}
export HF_DATASETS_CACHE=${HF_DIR}
export HUGGINGFACE_HUB_CACHE=${HF_DIR}
export HF_DATASETS_OFFLINE=1 
export HF_HUB_OFFLINE=1

export WANDB_MODE=offline

# cd to your dir & run script
cd /home/xxx/OpenRLHF
bash examples/scripts/sft_r1.sh
