theta = [2, 3, -1];
k = 5;
Model = @(x)Logistic_D_Opt2(x, theta, k);
lb = cat(2, -1 * ones(1, 2*k), zeros(1, k));
ub = cat(2, 1 * ones(1, 2*k), ones(1, k));
swarmsize = 128;
phi = 0.05;
maxiter = 500;

[criterion_val, opt_design] = csoma(Model, lb, ub, swarmsize, phi, maxiter);
