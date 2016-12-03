function [ entropies ] = Classwise_Entropy( X, Y, splits )
% compute class-wise entropy
%
% Input:
%   X       a vector of feature
%   Y       a vector of label, the same length with x
%   splits  a vector of split boundaries
%
% Output:
%   entropies   a vector of entropies corresponding to splits
%
% Author:   Zhifei Zhang
% Date:     Dec. 12, 2015
%

%% check input
if nargin < 3
    error('Not enough input arguments!')
end

if length(X) ~= length(Y)
    error('X and Y are mismatching!')
end

%% generate split indicator
X = reshape(X, length(X), 1);
split_indicator = double(repmat(X, [1 numel(splits)]) < ...
    repmat(reshape(splits, 1, length(splits)), [numel(X) 1]));

%% compute entropies
entropies = zeros(length(splits), 1);
for i = 1:length(splits)
    entropies(i) = cond_ent(split_indicator(:,i), Y);
end

