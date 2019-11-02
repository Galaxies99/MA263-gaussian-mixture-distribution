close all; clear all; clc

% generate X from normal distribution
mu1 = input('Please input mu1: ');
sigma1 = input('Please input sigma1: ');
X = normrnd(mu1, sigma1, [10000 1]);

% generate Y from normal distribution
mu2 = input('Please input mu2: ');
sigma2 = input('Please input sigma2: ');
Y = normrnd(mu2, sigma2, [10000 1]);

% generate eta
p = input('Please input p: ');
eta_prime = unifrnd(0, 1, [10000 1]);
eta = zeros(10000, 1);
eta(eta_prime <= p) = 1;

% generate Z = X + eta * Y
Z = X + eta .* Y;

% graphing
[counts, centers] = hist(Z, 70);
figure
bar(centers, counts / sum(counts))

% printing data to file
fp = fopen('gaussian_mixture_data.csv', 'w');
for i = 1 : 10000
    fprintf(fp, '%d,\n', Z(i, 1));
end
fclose(fp);
