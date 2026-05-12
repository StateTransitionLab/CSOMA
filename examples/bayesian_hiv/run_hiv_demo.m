% Small Bayesian HIV design run.
%
% This script uses deliberately small Monte Carlo settings so that the
% example is runnable as a check. Increase K, S, N, burnin, num_mu, and
% max_iter to reproduce the heavier manuscript experiments.

root = fileparts(fileparts(fileparts(mfilename('fullpath'))));
addpath(fullfile(root, 'src'));
addpath(fileparts(mfilename('fullpath')));

N = 5;
K = 5;
S = 5;

Omega = [0.26, 0, 0; 0, 2.5, 0; 0, 0, 2.5];
gamma_ = 3;
eta = [11, 1.1, -1];
Lambda = [6.0, 0, 0; 0, 0.1, 0; 0, 0, 0.01];
alpha = 4.5;
beta = 9.0;

num_mu = 4;
burnin = 20;
thinning = 2;

num_t = 16;
max_t = 7;
upper_t = max_t * ones(1, num_t);
lower_t = zeros(1, num_t);
swarmsize = 16;
phi = 0;
max_iter = 30;

obj = @(t)F_3(t, S, N, K, Omega, gamma_, eta, Lambda, alpha, beta, num_mu, burnin, thinning);
opts = struct('Seed', 2026, 'Display', true);

[fval, design] = csoma(obj, lower_t, upper_t, swarmsize, phi, max_iter, opts);
fprintf('Criterion value: %.8f\n', fval);
fprintf('Design: [%s]\n', num2str(sort(design), ' %.3f'));
