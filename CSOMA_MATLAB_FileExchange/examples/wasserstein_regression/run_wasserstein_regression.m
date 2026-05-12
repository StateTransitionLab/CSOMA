% Estimate a simple Wasserstein regression model by minimizing W2 loss.

root = fileparts(fileparts(fileparts(mfilename('fullpath'))));
addpath(fullfile(root, 'src'));
addpath(fileparts(mfilename('fullpath')));

rng(2026);
n = 28;
p_grid = linspace(0.02, 0.98, 80);
x = linspace(-1, 1, n)';
z = sqrt(2) * erfinv(2 * p_grid - 1);

theta_true = [0.50, 0.90, -0.25, 0.30];
location = theta_true(1) + theta_true(2) * x + 0.03 * randn(n, 1);
log_scale = theta_true(3) + theta_true(4) * x + 0.02 * randn(n, 1);
observed_quantiles = bsxfun(@plus, location, bsxfun(@times, exp(log_scale), z));

model = @(theta)Wasserstein_Regression_Objective(theta, x, p_grid, observed_quantiles);
lb = [-2, -2, -2, -1];
ub = [ 2,  2,  1,  1];
swarmsize = 64;
phi = 0.10;
maxiter = 150;
opts = struct('Seed', 2026, 'Display', false);

[loss_value, theta_hat] = csoma(model, lb, ub, swarmsize, phi, maxiter, opts);

fprintf('Wasserstein regression loss: %.8f\n', loss_value);
fprintf('True theta:      [%s]\n', num2str(theta_true, ' %.3f'));
fprintf('Estimated theta: [%s]\n', num2str(theta_hat, ' %.3f'));
