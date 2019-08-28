
PROBLEM=child_problem
MODEL=transformer
HPARAMS=transformer_base_single_gpu

DATA_DIR=t2t_data
TMP_DIR=t2t_datagen
TRAIN_DIR=t2t_train/child
CODEBASE=codebase


# check if TRAIN folder contain parent model
if [[ "$(ls $TRAIN_DIR/model* 2> /dev/null | wc -l)" == 0 ]]; then 
	echo "Provide parent model into the folder $TRAIN_DIR"; 
	exit 0;
fi

# Train child model
t2t-trainer \
	  --data_dir=$DATA_DIR \
	  --t2t_usr_dir=$CODEBASE \
      --problem=$PROBLEM \
      --model=$MODEL \
      --hparams_set=$HPARAMS \
	  --output_dir=$TRAIN_DIR \
	  --keep_checkpoint_max=100 \
	  --local_eval_frequency=1000 \
	  --train_steps=2000000 \
	  --hparams='batch_size=2400,max_length=100,learning_rate_schedule=rsqrt_decay,optimizer=Adafactor,learning_rate_warmup_steps=16000'

