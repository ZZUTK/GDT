function [ train_x, train_y, test_x, test_y ] = randLeaveout( x, y, leave )
% random leave xx% out
% Input:
%   x - observation, each raw is an observation
%   y - groundtruth, a column vector
%   leave - percentage of leave out, a value between 0 and 1
%
% Output:
%   train_x - observations for training
%   train_y - labels of training data
%   test_x - observation for testing
%   test_y - labels of testing data
%
% Author: Zhifei Zhang
% Date:     8/28/2015
%

if nargin < 3
    error('Not enough input arguments')
end

train_x = [];
train_y = [];
test_x = [];
test_y = [];

labels = unique(y);
for i=1:length(labels)
    indices = find(y==labels(i));
    n_test = ceil(length(indices) * leave);
    rand_index = randperm(length(indices));
    test_ind = indices( rand_index(1:n_test) );
    train_ind = indices( rand_index(n_test+1:end) );
    train_x = [train_x ; x(train_ind, :)];
    train_y = [train_y ; y(train_ind)];
    test_x = [test_x ; x(test_ind, :)];
    test_y = [test_y ; y(test_ind)];
end


