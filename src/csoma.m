function [minf, minx, history] = csoma(obj_fun, lb, ub, swarmsize, phi, maxiter, opts)
%CSOMA Competitive swarm optimizer with mutated agents.
%
%   [MINF, MINX] = CSOMA(OBJ_FUN, LB, UB, SWARMSIZE, PHI, MAXITER)
%   minimizes OBJ_FUN over the box constraints LB <= X <= UB. OBJ_FUN must
%   accept one row vector and return one scalar objective value.
%
%   [MINF, MINX, HISTORY] also returns the best objective value after each
%   iteration.
%
%   OPTS is optional. Supported fields:
%     Display  - true/false, print iteration progress. Default: false.
%     Seed     - numeric seed passed to rng. Default: do not set seed.
%
%   The interface is compatible with the original manuscript examples.

    if nargin < 7
        opts = struct();
    end
    if ~isfield(opts, 'Display')
        opts.Display = false;
    end
    if isfield(opts, 'Seed') && ~isempty(opts.Seed)
        rng(opts.Seed);
    end

    validateattributes(lb, {'numeric'}, {'row', 'real', 'finite'});
    validateattributes(ub, {'numeric'}, {'row', 'real', 'finite'});
    validateattributes(swarmsize, {'numeric'}, {'scalar', 'integer', '>=', 2});
    validateattributes(phi, {'numeric'}, {'scalar', 'real', 'finite', '>=', 0});
    validateattributes(maxiter, {'numeric'}, {'scalar', 'integer', '>=', 0});

    if length(lb) ~= length(ub)
        error('csoma:BoundsLengthMismatch', 'Lower and upper bounds must have equal length.');
    end
    if any(ub <= lb)
        error('csoma:InvalidBounds', 'Each upper bound must be greater than its lower bound.');
    end

    S = swarmsize;
    D = length(ub);
    pairnum = floor(S / 2);

    x = rand(S, D);
    x = bsxfun(@plus, lb, bsxfun(@times, ub - lb, x));
    v = zeros(S, D);
    fx = evaluate_swarm(obj_fun, x);
    history = zeros(maxiter + 1, 1);
    history(1) = min(fx);

    for iter = 1:maxiter
        swarm_center = mean(x, 1);
        shuffled = randperm(S);
        pairs = [shuffled(1:pairnum); shuffled(S-pairnum+1:S)]';

        first = pairs(:, 1);
        second = pairs(:, 2);
        first_loses = fx(first) > fx(second);
        losers = first;
        losers(~first_loses) = second(~first_loses);
        winners = second;
        winners(~first_loses) = first(~first_loses);

        R1 = rand(pairnum, D);
        R2 = rand(pairnum, D);
        R3 = rand(pairnum, D);
        v(losers, :) = R1 .* v(losers, :) ...
            + R2 .* (x(winners, :) - x(losers, :)) ...
            + phi .* R3 .* bsxfun(@minus, swarm_center, x(losers, :));
        x(losers, :) = x(losers, :) + v(losers, :);

        x(losers, :) = bsxfun(@min, bsxfun(@max, x(losers, :), lb), ub);

        mutation_idx = losers(randi(numel(losers)));
        mutation_dim = randi(D);
        mutation_values = [lb(mutation_dim), ub(mutation_dim), ...
            (lb(mutation_dim) + ub(mutation_dim)) / 2];
        x(mutation_idx, mutation_dim) = mutation_values(randi(3));

        fx(losers) = evaluate_swarm(obj_fun, x(losers, :));
        fx(mutation_idx) = obj_fun(x(mutation_idx, :));

        history(iter + 1) = min(fx);
        if opts.Display
            fprintf('Iter: %d, best fitness: %.8e\n', iter, history(iter + 1));
        end
    end

    [minf, min_index] = min(fx);
    minx = x(min_index, :);
end

function fx = evaluate_swarm(obj_fun, x)
    fx = zeros(size(x, 1), 1);
    for i = 1:size(x, 1)
        fx(i) = obj_fun(x(i, :));
    end
end
