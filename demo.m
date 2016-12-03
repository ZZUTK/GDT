%% A demo of Gaussian Decision Tree (GDT)
% this method is designed for classification on small dataset, 
% e.g., there are only two samples for training in each class.
%
% written by Zhifei, zzhang61@vols.utk.edu
%
clc; clear; close all

%% load data
load data/synth_data
% randomly select n samples 
n = 8;
% rng(0, 'v5uniform')
inds = randperm(size(X, 1), n);
X = X(inds, :);
Y = Y(inds);

%% GDT vs. Decision Tree (DT)
addpath('GDT')
% leave-xx%-out cross validation
xx = 0.1;
iter = 20;
[acc1, std1] = GDT_CrossValidation(X, Y, xx, iter, .1);
[acc2, std2] =  DT_CrossValidation(X, Y, xx, iter);
fprintf('Accuracy (std) of GDT vs. DT:\n\tGDT\t%.2f (%.2f)\n\tDT\t%.2f (%.2f)\n', ...
    acc1, std1, acc2, std2);