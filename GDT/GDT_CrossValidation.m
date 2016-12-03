function [ accuracy, stderror ] = GDT_CrossValidation( X, Y, leave, iter, g )
% cross validation using GDT
%
% Input:
%   X       an m-by-n matrix, each row is an obervation
%   Y       label of each obervation in X, a colume vector with m element
%   leave   random leave out percentage [0,1).
%   iter    times of validation
%   g       parameter of cost function
%
% Output:
%   accuracy    average accuracy of cross validation
%   stderror    standard error of the average accuracy
%
% Author:   Zhifei Zhang
% Date:     Jan. 4th, 2016
% 

%% check input
if nargin < 2
    error('Not enough input arguments!')
end

if nargin < 3
    leave = .2;
end

if nargin < 4
    iter = 10;
end

if nargin < 5
    g = .1;
end

accuracy = 0;
stderror = 0;

[m, n] = size(X);
if leave >= 1
    error('Error: the third input argument.')
end
if iter <= 0 
    error('Error: the forth input argument.')
else
    iter = ceil(iter);
end

%% cross validation
y_hat = [];
y_truth = [];
for loop = 1:iter
    % random leave out
    if leave == 0
        train_x = X;
        train_y = Y;
        test_x = X;
        test_y = Y;
    else
        [ train_x, train_y, test_x, test_y ] = randLeaveout( X, Y, leave );
    end
    
    % training
    T = GDT(train_x, train_y, g);
    
    % testing
    y_hat = [ y_hat , GDT_Classification(T, test_x) ];
    y_truth = [ y_truth , test_y ];
    
end % end of loop

temp = y_hat - y_truth == 0;
accuracy = mean(temp(:));
stderror = std(temp(:)) / sqrt(iter);















