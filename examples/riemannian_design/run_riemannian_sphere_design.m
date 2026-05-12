% D-optimal design for a linear model on the sphere S^2.

root = fileparts(fileparts(fileparts(mfilename('fullpath'))));
addpath(fullfile(root, 'src'));
addpath(fileparts(mfilename('fullpath')));

k = 6;
model = @(z)Riemannian_Sphere_D_Opt(z, k);
lb = [zeros(1, k), zeros(1, k), zeros(1, k)];
ub = [pi * ones(1, k), 2*pi * ones(1, k), ones(1, k)];
swarmsize = 80;
phi = 0.10;
maxiter = 180;
opts = struct('Seed', 2026, 'Display', false);

[criterion_value, opt_design] = csoma(model, lb, ub, swarmsize, phi, maxiter, opts);
theta = opt_design(1:k);
phi_angle = opt_design(k+1:2*k);
weights = opt_design(2*k+1:3*k);
weights = weights / sum(weights);
points = [sin(theta(:)) .* cos(phi_angle(:)), ...
          sin(theta(:)) .* sin(phi_angle(:)), ...
          cos(theta(:))];

fprintf('Sphere design criterion value: %.8f\n', criterion_value);
disp('Design matrix: columns are x, y, z, weight');
disp([points, weights(:)]);
