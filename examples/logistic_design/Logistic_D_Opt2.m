function criterion = Logistic_D_Opt2(z, theta, k)
%LOGISTIC_D_OPT2 Negative log determinant for a two-factor logistic design.
%
%   Z contains k x-coordinates, k y-coordinates, and k nonnegative raw
%   weights. The raw weights are normalized internally.

    x1 = z(1:k);
    x2 = z(k+1:2*k);
    raw_w = z(2*k+1:3*k);
    if any(raw_w < 0) || sum(raw_w) <= eps
        criterion = 1e12;
        return;
    end
    w = raw_w / sum(raw_w);

    M = logistic_information([x1(:), x2(:)], w(:), theta(:));
    criterion = -safe_logdet(M);
end

function M = logistic_information(points, weights, theta)
    X = [ones(size(points, 1), 1), points];
    eta = X * theta;
    omega = exp(eta) ./ (1 + exp(eta)).^2;
    M = X' * diag(weights .* omega) * X;
end

function y = safe_logdet(A)
    A = (A + A') / 2;
    jitter = 1e-10;
    [R, p] = chol(A + jitter * eye(size(A)));
    if p ~= 0
        y = -1e12;
    else
        y = 2 * sum(log(diag(R)));
    end
end
