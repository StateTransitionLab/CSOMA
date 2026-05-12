lb = zeros(1, n);
ub = ones(1, n);
phi = 0.1;
maxiter = 200;
swarmsize = 64;

obj_fun = @(route)TSP(route, n, DM);
[min_route_length, min_route] = csoma(obj_fun, lb, ub, swarmsize, phi, maxiter)
[~, min_route_idx] = sort(min_route);
order = [sprintf('\%d -> ', min_route_idx(1:end-1)), sprintf('\%d ->', min_route_idx(end)), sprintf(' \%d.', min_route_idx(1))];
strcat(''The shortest route is: '', order);

