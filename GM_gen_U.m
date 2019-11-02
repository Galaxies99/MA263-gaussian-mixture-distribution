close all; clear all; clc

% input n
n = input('Please input n:');

% initializing data
mu1 = 0; sigma1 = 2;
mu2 = 10; sigma2 = 3; p = 0.6;

% generating Z = X + eta * Y
X = normrnd(mu1, sigma1, [1000 n]);
Y = normrnd(mu2, sigma2, [1000 n]);
eta_prime = unifrnd(0, 1, [1000 n]);
eta = zeros(1000, n);
eta(eta_prime <= p) = 1;
Z = X + eta .* Y;

% computing E(Z_i) and D(Z_i) for each group
EZ = mean(mean(Z));
DZ = 0;
for i = 1 : 1000
    for j = 1 : n
        DZ = DZ + (Z(i, j) - EZ) .^ 2;
    end
end
DZ = DZ / (n * 1000);

% calculating U
for i = 1 : 1000
    tem = 0;
    for j = 1 : n
        tem = tem + Z(i, j);
    end
    U(i) = (tem - n * EZ) / sqrt(n * DZ);
end


% graphing
[counts, centers] = hist(U, 100);
figure
bar(centers, counts / sum(counts))

% printing data to file
fp = fopen('U_data.csv','w');
for i = 1 : 1000
    fprintf(fp, '%d,', U(i));
    for j = 1 : n
        fprintf(fp, '%d,', Z(i, j));
    end
    fprintf(fp, '\n');
end
fclose(fp);
