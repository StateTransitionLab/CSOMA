% Locally D-optimal approximate design for a two-factor logistic model.

root = fileparts(fileparts(fileparts(mfilename('fullpath'))));
addpath(fullfile(root, 'src'));
addpath(fileparts(mfilename('fullpath')));

theta = [2, 3, -1];
k = 5;
model = @(x)Logistic_D_Opt2(x, theta, k);
lb = cat(2, -1 * ones(1, 2*k), zeros(1, k));
ub = cat(2,  1 * ones(1, 2*k), ones(1, k));
swarmsize = 64;
phi = 0.05;
maxiter = 150;
opts = struct('Seed', 2026, 'Display', false);

[criterion_val, opt_design] = csoma(model, lb, ub, swarmsize, phi, maxiter, opts);
opt_design(2*k+1:3*k) = opt_design(2*k+1:3*k) / sum(opt_design(2*k+1:3*k));

fprintf('Criterion value: %.8f\n', criterion_val);
disp('Design matrix: columns are x1, x2, weight');
disp(reshape(opt_design, [k, 3]));

sen_fun = @(x, y)Sen_fun_log2([x, y], opt_design, theta, k);
fprintf('Sensitivity at (0, 0): %.8f\n', sen_fun(0, 0));
