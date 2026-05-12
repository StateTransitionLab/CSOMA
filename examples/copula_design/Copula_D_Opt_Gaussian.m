function value = Copula_D_Opt_Gaussian(z, theta, k)
%COPULA_D_OPT_GAUSSIAN Negative log determinant for a Gaussian copula design.
%
%   Z contains k support points followed by k nonnegative raw weights. THETA is
%   [beta10 beta11 beta20 beta21 zeta], where rho = tanh(zeta).

    x = z(1:k);
    raw_w = z(k+1:2*k);

    if any(raw_w < 0) || sum(raw_w) <= 1e-12
        value = 1e10;
        return;
    end

    w = raw_w / sum(raw_w);
    info = zeros(5, 5);
    for i = 1:k
        info = info + w(i) * gaussian_copula_info(x(i), theta);
    end

    info = (info + info') / 2;
    [chol_factor, flag] = chol(info);
    if flag ~= 0
        value = 1e8 + sum(abs(info(:)));
        return;
    end

    value = -2 * sum(log(diag(chol_factor)));
end
