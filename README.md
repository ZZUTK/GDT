# GDT
A demo of Gaussian-based Decision Tree, which is designed for classification on small dataset, e.g., there are only two sample for training in each category.

## Pre-requisite
* Matlab

## Run the demo
```
>> demo
```

The result will be printed like
```
Accuracy (std) of GDT vs. DT:
	GDT	0.75 (0.10)
	DT	0.50 (0.11)
```
It may vary for each run because the random selection of training samples.

## Citation
Z. Zhang, Y. Song, H. Cui, J. Wu, F. Schwartz, and H. Qi.
"Topological Analysis and Gaussian Decision Tree: Effective Representation and Classification of Biosignals of Small Sample Size".
*IEEE Transactions on Biomedical Engineering (TBME)*, 2016. [[PDF](http://media.wix.com/ugd/fc09cd_ca9859d841034c8babccec958aa7db54.pdf)]

Z. Zhang, Y. Song, H. Cui, J. Wu, F. Schwartz, and H. Qi.
"Early Mastitis Diagnosis through Topological Analysis of Biosignalsfrom Low-Voltage Alternate Current Electrokinetics".
*International Conference on the IEEE Engineering in Medicine and Biology Society (EMBC)*, 2015. [[PDF](http://media.wix.com/ugd/fc09cd_e5a9fe286d2e49e78f8584ff002f0372.pdf)]

```
@inproceedings{zhang2015early,
  title={Early mastitis diagnosis through topological analysis of biosignals from low-voltage alternate current electrokinetics},
  author={Zhang, Zhifei and Song, Yang and Cui, Haochen and Wu, Jayne and Schwartz, Fernando and Qi, Hairong},
  booktitle={2015 37th Annual International Conference of the IEEE Engineering in Medicine and Biology Society (EMBC)},
  pages={542--545},
  year={2015},
  organization={IEEE}
}
```
