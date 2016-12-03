function [ intersections, values, mu, sigma ] = Gaussian_intersection( X, Y )
% compute intersection of Gaussian curves fitted to each class of data
%
% Input:
%   X   a vector of feature values
%   Y   a vector of the label of each value
%
% Output:
%   intersections   intersections of Gaussian curves fitted to the data
%                   of each class
%   values          Gaussian values at the intersections
%   mu, sigma       mean and standard deviation of each Gaussian curve
%

%% check input
if nargin < 2
    error('Not enough input arguments!')
end

if length(unique(Y))<2
    error('Y is consistent')
end

%% compute mean and variance of each class
class_labels = unique(Y);
n_class = length(class_labels);
mu = zeros(n_class, 1);
sigma = zeros(n_class, 1);
for i = 1:n_class
   temp = X(Y==class_labels(i));
   mu(i) = mean(temp);
   sigma(i) = std(temp);
end
mat = sortrows([mu sigma class_labels]);
mu = mat(:,1);
sigma = mat(:,2);
class_labels = mat(:,3);
if sum(sigma~=0) < 2
    intersections = 0.5*(mu(1:end-1) + mu(2:end)); 
    values = 1 ./ ( mu(2:end) - mu(1:end-1) + eps);
    return
end

%% adjust zero variance
ind_nonzero_sigma = find(sigma~=0);
if sigma(1) == 0
    sigma(1) = sigma(ind_nonzero_sigma(1)) / sqrt(sum(Y==class_labels(1)));
end
if sigma(end) == 0
    sigma(end) = sigma(ind_nonzero_sigma(end)) / sqrt(sum(Y==class_labels(end)));
end
if length(mu) > 2 && sum(sigma==0)>0
    ind_nonzero_sigma = find(sigma~=0);
    sigma = interp1(mu(ind_nonzero_sigma),sigma(ind_nonzero_sigma), mu, 'spline');
end
%% find intersections
intersections = zeros(n_class-1, 1);
values = intersections;
for i = 1:n_class-1
    if mu(i)==mu(i+1)
        intersections(i) = mu(i);
        values(i) = normpdf(mu(i), mu(i), sigma(i));
    else
        x = linspace(mu(i), mu(i+1), 1000);
        y1 = normpdf(x, mu(i), sigma(i));
        y2 = normpdf(x, mu(i+1), sigma(i+1));
        y = abs(y1 - y2);
        [~, loc] = min(y);
        intersections(i) = x(loc);
        values(i) = y1(loc);
    end
end







