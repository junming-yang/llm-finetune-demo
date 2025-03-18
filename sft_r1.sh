set -x

read -r -d '' training_commands <<EOF
openrlhf.cli.train_sft \
   --max_len 4096 \
   --dataset ./data/r1_dataset_17k.json \
   --input_key input \
   --output_key output \
   --train_batch_size 256 \
   --micro_train_batch_size 4 \
   --pretrain ${HF_HOME}/${model_path} \ # 修改模型地址
   --save_path ./checkpoint/qwen2.5-1.5b-inst-r1-17k \ # 修改数据路径
   --save_steps -1 \
   --logging_steps 1 \
   --eval_steps -1 \
   --zero_stage 2 \
   --max_epochs 1 \
   --bf16 \
   --flash_attn \
   --packing_samples \
   --learning_rate 5e-5 \
   --apply_chat_template \
   --load_checkpoint \
   --gradient_checkpointing
EOF
    # --wandb [WANDB_TOKENS]
    # --packing_samples

if [[ ${1} != "slurm" ]]; then
    deepspeed --module $training_commands
fi