function [ T ] = GDT( X, Y, g, feature_names )
% Gaussian-based Decision Tree
% 
% Input: 
%   X       an m-by-n matrix, each row is an obervation
%   Y       label of each obervation in X, a colume vector with m element
%   g       parameter of cost function
%   feature_names   names of the features, a cell vector
%
% Output:
%   T   Gaussian-based decision tree
%       T.parent    a vector that indexes each node's parent node
%       T.indices   the rows of x in each node (non-empty only for leaves)
%       T.labels    a vector of labels showing the decision 
%                   that was made to get to that node
%       T.classes   class labels of the samples divided into a node 
% 
%
% Author:   Zhifei Zhang, Thanks to CIS520: Machine Learning from Penn
% Date:     Dec. 17th, 2015
% 

%% check input 
if nargin < 2
    error('Not enough input argument!')
end
[m, n] = size(X);
if length(Y) ~= m
    error('Dimension mismatching (x and y)!')
end
Y = reshape(Y, m, 1);
if nargin < 3
    g = .1;
end
if nargin < 4
    feature_names = cell(1, n);
    for i = 1:n
        feature_names{i} = num2str(i);
    end
end

%% Create an empty decision tree, which has one node and everything in it
indices = {1:size(X,1)}; % A cell per node containing indices of all data in that node
parent = 0; % Vector contiaining the index of the parent node for each node
labels = {}; % A label for each node
classes = {};
% Create tree by splitting on the root
[indices, parent, labels, classes] = ...
    split_node(X, Y, indices, parent, labels, feature_names, classes, 1, g);
T.indices = indices;
T.parent = parent;
T.labels = labels;
T.classes = classes;

function [indices, parent, labels, classes] = split_node(X, Y, indices, parent, labels, feature_names, classes, node, g)
% Recursively splits nodes based on information gain
% Check if the current leaf is consistent
if numel(unique(Y(indices{node}))) == 1
    return;
end
% Check if all inputs have the same features
% We do this by seeing if there are multiple unique rows of X
if size(unique(X(indices{node},:),'rows'),1) == 1
    return;
end
% Otherwise, we need to split the current node on some feature
best_cost = inf; %best information gain
best_feature = 0; %best feature to split on
best_value = 0; % best value to split the best feature on
current_X = X(indices{node},:);
current_Y = Y(indices{node});
% Loop over each feature
for i = 1:size(X,2)
    feature = current_X(:,i);
    % Check if the feature has the same value
    values = unique(feature);
    if numel(values) < 2
        continue
    end
    % Deterimine the values to split on: intersections of Gaussian
    [splits, prob, mu, sigma] = Gaussian_intersection(feature, current_Y);
    % Compute the cost
    %           Gaussian(mu_i, sigma_i, x)
    % cost(x) = --------------------------  +  gamma*Entropy(x)
    %                 mu_{i+1} - mu_i
    term1 = prob ./ ( mu(2:end)-mu(1:end-1) + eps);
    term2 = g * Classwise_Entropy( feature, current_Y, splits );
    % Find the best split
    [val, ind] = min( term1 + term2 );
    if val < best_cost
        best_cost = val;
        best_feature = i;
        best_value = splits(ind);
    end
end
% Split the current node into two nodes
feature = current_X(:,best_feature);
feature = feature < best_value;
indices = [indices; indices{node}(feature); indices{node}(~feature)];
classes = [classes; Y(indices{end-1}); Y(indices{end})];
indices{node} = [];
parent = [parent; node; node];
labels = [labels; sprintf('%s < %2.2f', feature_names{best_feature}, best_value); ...
    sprintf('%s >= %2.2f', feature_names{best_feature}, best_value)];
% Recurse on newly-create nodes
n = numel(parent)-2;
[indices, parent, labels, classes] = split_node(X, Y, indices, parent, labels, feature_names, classes, n+1, g);
[indices, parent, labels, classes] = split_node(X, Y, indices, parent, labels, feature_names, classes, n+2, g);

