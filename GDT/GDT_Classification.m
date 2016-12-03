function [ Y_hat ] = GDT_Classification( T, X )
% Classification based on Gaussian-based Decision Tree
% 
% Input: 
%   T       Gaussian-based decision tree
%   X       an m-by-n matrix, each row is an obervation
%
% Output:
%   Y_hat   predicted label
%
%
% Author:   Zhifei Zhang
% Date:     Jan. 4th, 2016
% 

%% check input 
if nargin < 2
    error('Not enough input argument!')
end

[m, n] = size(X);
Y_hat = zeros(m, 1);

%% splitting boundary
temp = T.labels;
split = zeros(length(temp), 3);
% split feature
split(:, 1) = cellfun(@(x) str2double(regexp(x, '\d+\s', 'match')), temp);
% split flag
split(:, 2) = cellfun(@(x) strcmp(regexp(x, '\s.+\s', 'match'),' < '), temp);
% split boundary
split(:, 3) = cellfun(@(x) str2double(regexp(x, '\d+.\d+', 'match')), temp);

%% classification
for i = 1:m
    x = X(i, :);
    node_path = 1;
    while 1
       child_nodes = find(T.parent == node_path(end)); 
       if isempty(child_nodes)
           break
       end
       split_feature = split(child_nodes(1), 1);
       if split_feature > n
           error('Mismatching: numbers of features in the tree and obervation')
       end
       split_boundary = split(child_nodes(1), 3);
       split_flag = x(split_feature) >= split_boundary;
       node_path = [node_path ; child_nodes(split_flag+1)];
    end
    % correlate index
    node_path = node_path - 1;
    % compute probability of class prediciton (avoid over fitting)
    Y_hat(i) = T.classes{node_path(end)}(1);
end











