% Run the fast CSOMA replication checks.
%
% The Bayesian HIV and high-dimensional examples can be computationally
% expensive. They are included in examples/ and can be run separately.

clear; clc;
root = fileparts(fileparts(mfilename('fullpath')));
addpath(fullfile(root, 'src'));

fprintf('Running CSOMA smoke test...\n');
run(fullfile(root, 'examples', 'basic', 'run_basic.m'));

fprintf('\nRunning logistic-design example...\n');
run(fullfile(root, 'examples', 'logistic_design', 'run_logistic_design.m'));

fprintf('\nRunning Gaussian copula design example...\n');
run(fullfile(root, 'examples', 'copula_design', 'run_copula_design.m'));

fprintf('\nRunning Gaussian copula MLE example...\n');
run(fullfile(root, 'examples', 'copula_design', 'run_copula_mle.m'));

fprintf('\nRunning Wasserstein regression example...\n');
run(fullfile(root, 'examples', 'wasserstein_regression', 'run_wasserstein_regression.m'));

fprintf('\nRunning Riemannian sphere design example...\n');
run(fullfile(root, 'examples', 'riemannian_design', 'run_riemannian_sphere_design.m'));

fprintf('\nRunning TSP example...\n');
run(fullfile(root, 'examples', 'tsp', 'run_tsp.m'));

fprintf('\nFast replication checks completed.\n');
