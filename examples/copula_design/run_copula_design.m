% Locally D-optimal design for a Gaussian copula dependence model.

root = fileparts(fileparts(fileparts(mfilename('fullpath'))));
addpath(fullfile(root, 'src'));
addpath(fileparts(mfilename('fullpath')));

theta = [0, 1, -0.5, 0.75, atanh(0.6)];
k = 5;
model = @(z)Copula_D_Opt_Gaussian(z, theta, k);
lb = [-ones(1, k), zeros(1, k)];
ub = [ ones(1, k), ones(1, k)];
swarmsize = 64;
phi = 0.10;
maxiter = 150;
opts = struct('Seed', 2026, 'Display', false);

[criterion_val, opt_design] = csoma(model, lb, ub, swarmsize, phi, maxiter, opts);
support = opt_design(1:k);
weights = opt_design(k+1:2*k);
weights = weights / sum(weights);

fprintf('Copula design criterion value: %.8f\n', criterion_val);
disp('Design matrix: columns are support point and weight');
disp([support(:), weights(:)]);
