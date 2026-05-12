theta = [0, 1, -0.5, 0.75, atanh(0.6)];
k = 5;
Model = @(z)Copula_D_Opt_Gaussian(z, theta, k);
lb = [-ones(1, k), zeros(1, k)];
ub = [ ones(1, k), ones(1, k)];
swarmsize = 64;
phi = 0.10;
maxiter = 150;

[criterion_val, opt_design] = csoma(Model, lb, ub, swarmsize, phi, maxiter);
