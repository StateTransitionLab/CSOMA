function value = Wasserstein_Regression_Objective(theta, x, p_grid, observed_quantiles)
%WASSERSTEIN_REGRESSION_OBJECTIVE Integrated W2 loss for quantile regression.
%
%   The model is Q(p | x) = a0 + a1*x + exp(b0 + b1*x)*Phi^{-1}(p).
%   For univariate distributions, squared W2 distance is the L2 distance
%   between quantile functions.

    x = x(:);
    z = sqrt(2) * erfinv(2 * p_grid(:)' - 1);

    location = theta(1) + theta(2) * x;
    log_scale = theta(3) + theta(4) * x;
    if any(abs(log_scale) > 20)
        value = 1e10 + sum(abs(log_scale));
        return;
    end

    scale = exp(log_scale);
    predicted_quantiles = bsxfun(@plus, location, bsxfun(@times, scale, z));
    residual = predicted_quantiles - observed_quantiles;
    value = mean(residual(:).^2);

    if ~isfinite(value)
        value = 1e12;
    end
end
