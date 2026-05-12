function value = Copula_MLE_Gaussian(zeta, U)
%COPULA_MLE_GAUSSIAN Negative pseudo log-likelihood for a Gaussian copula.
%
%   U is an n-by-2 matrix of pseudo-observations on (0, 1). The scalar ZETA
%   parameterizes the correlation by rho = tanh(zeta), keeping rho in (-1, 1).

    rho = tanh(zeta(1));
    U = min(max(U, 1e-8), 1 - 1e-8);
    q = sqrt(2) * erfinv(2 * U - 1);
    z1 = q(:, 1);
    z2 = q(:, 2);

    denom = 1 - rho^2;
    log_density = -0.5 * log(denom) ...
        - 0.5 * (rho^2 * (z1.^2 + z2.^2) - 2 * rho * z1 .* z2) / denom;

    value = -sum(log_density);
    if ~isfinite(value)
        value = 1e12;
    end
end
