% Basic smoke test for CSOMA.
%
% This example is intentionally small so that reviewers can verify the
% package setup quickly before running the heavier manuscript examples.

root = fileparts(fileparts(fileparts(mfilename('fullpath'))));
addpath(fullfile(root, 'src'));

obj_fun = @(x)sum((x - [0.25, -0.50, 0.75]).^2);
lb = -ones(1, 3);
ub = ones(1, 3);
swarmsize = 24;
phi = 0.10;
maxiter = 80;
opts = struct('Seed', 1, 'Display', false);

[best_value, best_x, history] = csoma(obj_fun, lb, ub, swarmsize, phi, maxiter, opts);

fprintf('Best value: %.8g\n', best_value);
fprintf('Best x: [%s]\n', num2str(best_x, ' %.4f'));
fprintf('Initial best: %.8g, final best: %.8g\n', history(1), history(end));
