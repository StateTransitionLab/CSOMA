function info = gaussian_copula_info(x, theta)
%GAUSSIAN_COPULA_INFO Elemental Fisher information for a bivariate normal copula.
%
%   The normal margins have means beta10 + beta11*x and beta20 + beta21*x,
%   unit variances, and Gaussian copula correlation rho = tanh(zeta).

    zeta = theta(5);
    rho = tanh(zeta);
    sigma = [1, rho; rho, 1];
    sigma_inv = inv(sigma);

    dmu = [1, x, 0, 0;
           0, 0, 1, x];
    mean_block = dmu' * sigma_inv * dmu;

    drho = 1 - rho^2;
    dsigma = drho * [0, 1; 1, 0];
    zeta_info = 0.5 * trace(sigma_inv * dsigma * sigma_inv * dsigma);

    info = zeros(5, 5);
    info(1:4, 1:4) = mean_block;
    info(5, 5) = zeta_info;
end
