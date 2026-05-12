function value = Riemannian_Sphere_D_Opt(z, k)
%RIEMANNIAN_SPHERE_D_OPT Negative log determinant for a design on S^2.
%
%   The first k variables are polar angles in [0, pi], the next k variables
%   are azimuthal angles in [0, 2*pi], and the final k variables are raw
%   design weights.

    theta = z(1:k);
    phi = z(k+1:2*k);
    raw_w = z(2*k+1:3*k);

    if any(raw_w < 0) || sum(raw_w) <= 1e-12
        value = 1e10;
        return;
    end
    w = raw_w(:) / sum(raw_w);

    points = [sin(theta(:)) .* cos(phi(:)), ...
              sin(theta(:)) .* sin(phi(:)), ...
              cos(theta(:))];
    features = [ones(k, 1), points];
    info = features' * bsxfun(@times, features, w);
    info = (info + info') / 2;

    [chol_factor, flag] = chol(info);
    if flag ~= 0
        value = 1e8 + sum(abs(info(:)));
        return;
    end

    value = -2 * sum(log(diag(chol_factor)));
end
