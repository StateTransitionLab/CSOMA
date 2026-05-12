Model = @(zeta)Copula_MLE_Gaussian(zeta, U);
lb = -3;
ub = 3;
swarmsize = 48;
phi = 0.10;
maxiter = 120;

[neg_loglik, zeta_hat] = csoma(Model, lb, ub, swarmsize, phi, maxiter);
rho_hat = tanh(zeta_hat);
