function value = Sen_fun_log2(point, opt_design, theta, k)
%SEN_FUN_LOG2 D-optimality sensitivity for a two-factor logistic design.

    x1 = opt_design(1:k);
    x2 = opt_design(k+1:2*k);
    raw_w = opt_design(2*k+1:3*k);
    w = raw_w(:) / sum(raw_w);

    X = [ones(k, 1), x1(:), x2(:)];
    eta = X * theta(:);
    omega = exp(eta) ./ (1 + exp(eta)).^2;
    M = X' * diag(w .* omega) * X;

    f = [1; point(1); point(2)];
    eta_point = f' * theta(:);
    omega_point = exp(eta_point) / (1 + exp(eta_point))^2;
    value = omega_point * (f' / M * f) - length(theta);
end
