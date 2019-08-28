# name of the problem in codebase/child.py ... notice that uppercase letters are lowecased and underscore is added in front of them.
PROBLEM=child_problem

DATA_DIR=t2t_data
TMP_DIR=t2t_datagen
CODEBASE=codebase

# Generate data
t2t-datagen \
    --data_dir=$DATA_DIR \
	--t2t_usr_dir=$CODEBASE \
    --tmp_dir=$TMP_DIR \
    --problem=$PROBLEM

