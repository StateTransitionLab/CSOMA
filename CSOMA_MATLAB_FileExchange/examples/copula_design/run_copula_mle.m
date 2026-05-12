% Maximum pseudo-likelihood estimation for a Gaussian copula.

root = fileparts(fileparts(fileparts(mfilename('fullpath'))));
addpath(fullfile(root, 'src'));
addpath(fileparts(mfilename('fullpath')));

rng(2026);
n = 400;
rho_true = 0.55;
z1 = randn(n, 1);
z2 = rho_true * z1 + sqrt(1 - rho_true^2) * randn(n, 1);
U = 0.5 * (1 + erf([z1, z2] / sqrt(2)));

model = @(zeta)Copula_MLE_Gaussian(zeta, U);
lb = -3;
ub = 3;
swarmsize = 48;
phi = 0.10;
maxiter = 120;
opts = struct('Seed', 2027, 'Display', false);

[neg_loglik, zeta_hat] = csoma(model, lb, ub, swarmsize, phi, maxiter, opts);
rho_hat = tanh(zeta_hat);

fprintf('Gaussian copula negative log-likelihood: %.8f\n', neg_loglik);
fprintf('True rho: %.3f, estimated rho: %.3f\n', rho_true, rho_hat);
