k = 6;
Model = @(z)Riemannian_Sphere_D_Opt(z, k);
lb = [zeros(1, k), zeros(1, k), zeros(1, k)];
ub = [pi * ones(1, k), 2*pi * ones(1, k), ones(1, k)];
swarmsize = 80;
phi = 0.10;
maxiter = 180;

[criterion_value, opt_design] = csoma(Model, lb, ub, swarmsize, phi, maxiter);
