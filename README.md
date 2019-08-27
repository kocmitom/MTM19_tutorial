# MTM19 tutorial
## Transfer Learning for Low-Resource Languages

This tutorial will teach you, how to use the Tensor2Tensor and how to apply Transfer Learning to low-resource languages.

The idea is that whenewer you have low-resource language pair that has not enough training data, we can pretrain model on ANY other language pair and use the pretrained model as a starting point for the low-resource training.

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


## Train parent model (English-to-Czech)

Now as you prepared vocabulary, you can preprocess dataset with the wordpieces and start parent training. The training would take several days or weeks, thus we skip this step and download already trained parent model:

```
TODO
```

However, this pipeline can be used for real life training, therefore following steps cas used to train the parent English-to-Czech model (please beware that parent training data you have are downsampled, for actuall training use whole CzEng 1.7 corpora).

```
TODO
```

## Preparation of data for child (English-to-Estonian)

## Transfer parent model

## Train child model

## Evaluate child

