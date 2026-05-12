Model = @(theta)Wasserstein_Regression_Objective(theta, x, p_grid, observed_quantiles);
lb = [-2, -2, -2, -1];
ub = [ 2,  2,  1,  1];
swarmsize = 64;
phi = 0.10;
maxiter = 150;

[loss_value, theta_hat] = csoma(Model, lb, ub, swarmsize, phi, maxiter);
