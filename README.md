# MTM19 tutorial
## Transfer Learning for Low-Resource Languages

This tutorial will teach you, how to use the Tensor2Tensor and how to apply Transfer Learning to low-resource languages.

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
pip install tensor2tensor[tensorflow_gpu]
```

Before running any of the following commands, you always need to source the environment.

# Transfer Learning

The Transfer Learning pipeline has following steps:

1. Preparation of vocabulary (shared between parent and child)
2. Train parent model (English-to-Czech)
3. Preparation of data for child (English-to-Estonian)
4. Transfer parent model
5. Train child model
6. Evaluate child

## Preparation of vocabulary

## Train parent model (English-to-Czech)

## Preparation of data for child (English-to-Estonian)

## Transfer parent model

## Train child model

## Evaluate child

