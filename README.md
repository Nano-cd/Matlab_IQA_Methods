# Matlab_IQA_Methods
Some commonly used traditional image quality Assesment methods


## Install

```js
install requeried tools: Matlab c++
```

## Usage
```
$ readme README.md
```

```js

// Checks readme in current working directory

You need:
1)define your own data and train-test split
2)run Comp_main.m (only for methods: BRISQUE FRIQUEE  GLBP) to get features.
3)run SSEQ/SSEQ_MAIN.m for methods:SSEQ
4)run niqqe_release/example.m for methods:NIQE

notice: you need to change some para to run those methods because diff num of train-set
for example in IQA_predict.m, you should change the length of train_split and test_split

5)run tool_mean_std.m for calculating the mean and std performance

```
