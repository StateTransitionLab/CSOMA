# CSOMA JSS Code Package

This directory contains a MATLAB code package prepared for the accompanying
Journal of Statistical Software manuscript on the competitive swarm optimizer
with mutated agents (CSO-MA).

## Contents

- `src/csoma.m`: core CSO-MA optimizer.
- `src/csoma_addpaths.m`: helper to add package paths in MATLAB.
- `examples/basic`: a small smoke test.
- `examples/logistic_design`: two-factor logistic D-optimal design example.
- `examples/copula_design`: Gaussian copula D-optimal design and maximum
  pseudo-likelihood examples.
- `examples/wasserstein_regression`: Wasserstein regression estimation for
  distribution-valued responses.
- `examples/riemannian_design`: D-optimal design on the sphere as a simple
  Riemannian-manifold example.
- `examples/tsp`: travelling salesman example.
- `examples/high_dim_d_optimal`: high-dimensional D-optimal design code from
  the reference repository.
- `examples/bayesian_hiv`: Bayesian HIV design code from the reference
  repository, with a cleaned runnable driver.
- `examples/fractional_polynomial`: fractional polynomial design code from the
  reference repository.
- `replication/run_all.m`: fast replication entry point for reviewers.
- `docs/original_github_README.md`: README from the reference GitHub repository.
- `docs/manuscript_code_fragments`: code fragments extracted from the manuscript
  draft.

## Quick Start

From MATLAB, run:

```matlab
cd CSOMA_JSS_code
addpath('src')
run('replication/run_all.m')
```

The fast replication script runs lightweight examples that check the optimizer,
logistic design example, Gaussian copula design and MLE examples, Wasserstein
regression, Riemannian sphere design, and TSP example. Heavier
Monte Carlo examples are provided under `examples/` and should be run separately.

## Core Usage

```matlab
obj_fun = @(x)sum(x.^2);
lb = -ones(1, 5);
ub = ones(1, 5);
[best_value, best_x] = csoma(obj_fun, lb, ub, 32, 0.1, 100);
```

`csoma` minimizes a scalar objective function over box constraints. The objective
function should accept one row vector and return one scalar value.

## Requirements

The core optimizer uses base MATLAB functions only. Some advanced examples use
functions from the Statistics and Machine Learning Toolbox, including `mvnrnd`,
`wishrnd`, `gamrnd`, and `normrnd`.

## License

The package is distributed under the MIT License. MIT is GPL-compatible and is
acceptable for software distribution with JSS submissions.

## Reference Source

The code package was prepared using the public repository
`https://github.com/ElvisCuiHan/CSOMA` as a reference. The source snapshot used
locally was commit `4005137`.
