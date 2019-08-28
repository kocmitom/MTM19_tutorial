# MTM19 tutorial

This tutorial will teach you, how to use the Tensor2Tensor and how to apply Transfer Learning to low-resource languages. It should be easy to follow for everyone, even people that never trained Machine Translation models.

## Transfer Learning for Low-Resource Languages

The idea of transfer learning is that whenewer you have low-resource language pair that has not enough training data, we can pretrain model on ANY other language pair and use the pretrained model as a starting point for the low-resource training.

The tutorial is based on paper:

> Tom Kocmi and Ondřej Bojar. 2018. Trivial Transfer Learning for Low-Resource
Neural Machine Translation. *In Proceedings of the 3rd Conference on Machine
Translation (WMT): Research Papers*, Brussels, Belgium.

## Local Machines

For those using local machines:

> user: .\mtm2019

> pass: machineXYZ (XYZ are last 3 characters of your machine name)

Virtual machine:

> user: mtm

> pass: mtm19

## Virtual Env. Installation

In case you are using private machines, you need to prepare environment:

```
virtualenv --python=/opt/python/3.6.3/bin/python3 env-gpu
source env-gpu/bin/activate
pip install tensor2tensor[tensorflow_gpu] sacrebleu
```

Before running any of the following commands, you always need to source the environment.

# Transfer Learning

We are using following naming convention. `Parent` is the model trained on a high-resource language pair. `Child` is the low-resource model.

In this tutorial we use English-to-Czech as a parent model and English-to-Estonian as a child model.

The Transfer Learning pipeline has following steps:

1. Obtain parallel data
2. Preparation of vocabulary (shared between parent and child)
3. Train parent model (English-to-Czech)
4. Preparation of data for child (English-to-Estonian)
5. Transfer parent model
6. Train child model
7. Evaluate child model

## Obtain parallel data

Training data for the tutorial are from [WMT 2019](http://www.statmt.org/wmt19/translation-task.html).

In order to save time, there are prepared here:

```
wget http://ufallab.ms.mff.cuni.cz/~kocmanek/mtm19/data.tar.gz
tar -xvzf data.tar.gz
```

We are not going to train the parent model, thus the parent training model is reduced to 200k sentences.

The child data are 50k sentences randomly selected from English-Estonian corpora.

The development and test sets are from WMT 2019

## Preparation of vocabulary

Wordpieces (or BPE) can segment any text, however it is better to use vocabulary that contain language specific subwords. In order to have vocabulary, that contain parent and child subwords, we need to prepare shared vocabulary in advance.

### Task 1

Take *equal amount* of parallel data from each training corpora and combine them together into one file called `mixed.txt`.

Then run:

```
python generate_vocab.py
```

This created vocabulary `vocab.cseten.2k` in `t2t_data` with only 2k subwords containing all languages from parent and child. Note that the size of vocabulary is much smaller than usually as we are dealing with the low-resource child language pair.

## Train parent model (English-to-Czech)

Now as you prepared vocabulary, you can preprocess dataset with the wordpieces and start parent training. The training would take several days or weeks, thus we skip this step and download already trained parent model:

```
wget http://ufallab.ms.mff.cuni.cz/~kocmanek/mtm19/parent.tar.gz
tar -xvzf parent.tar.gz
```

Note that it will override your vocabulary to make sure that the vocabulary has exactly same subwords as the trained parent.
This model has been trained for TODO.

This pipeline can be used for real life training, therefore following steps cas used to train the parent English-to-Czech model (please beware that parent training data you have are downsampled, for actuall training use whole CzEng 1.7 corpora).

```
./train_parent.sh
```

## Preparation of data for child (English-to-Estonian)

Before training child model, Tensor2Tensor needs to preprocess data. For this we are going to create our own training problem and preprocess data for the training.

### Task 2

Open file `codebase/child.py` and modify rows 8 and 9 by providing the correct name of the child training corpora. T2T will look for the corpora in folder `t2t_datagen` where are all temporary files. 

Furthermore, provide a correct name of vocabulary on the row 16.

After that, preprocess the corpus by following command:

```
preprocess_child_corpus.sh
```

It will preprocess the corpus and store it in `t2t_data`.

## Transfer parent model

At this point we have English-to-Czech model and preprocessed child data. We need to make last step and that is to transfer parameters from parent to child.

We use feature of tensor2tensor framework, which continue training from the last checkpoint. Therefore we only need to provide the tensor2tensor with the checkpoint to the parent model. 

### Task 3

Copy last checkpoint from `t2t_train/parent` into `t2t_train/child`. You need to copy all files except for events\*

## Train child model

The last step is to train the child model. It is done by running following command

```
train_child_model.sh
```

The training is going to take XXX hours to train the model. Note that the training script for the child is optimized to stop at the best training step. If you use this pipeline for real life training, you need to watch the performance on the development set in order to prevent overfitting, which is often seen on low-resource language pairs.

## Evaluate child

The final model can be tested by following command:

```
MODEL=child FILE=t2t_datagen/test-newstest2018-enet.src ./translate_file.sh
```

Or even the parent model:

```
MODEL=parent FILE=t2t_datagen/test-newstest2018-encs.src ./translate_file.sh
```

You can change beam size to higher value (for example 4) and obtain better output.

In order to compute BLEU, you can check the output as follows:

```
cat output.translation | sacrebleu t2t_datagen/test-newstest2018-enet.ref
```

You should obtain TODO BLEU.

To summarize, you trained English-to-Estonian neural machine transltion with only 50k training data. If trained from scratch withou the transfer learning, we would obtain TODO BLEU. For this reason, we used parent translating English-to-Czech and updated it for the need of child language pair.
