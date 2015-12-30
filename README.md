# OptimizationBenchmarks.jl
Some benchmark optimization problems for testing new algorithms

## Example

```julia
using OptimizationBenchmarks
using Optim
@elapsed optimize(rosenbrock, [0.0, 0.0], method = :bfgs)
```

## Details

* Differentiable objective functions (e.g. `rosenbrock`) are provided as `TwiceDifferentiableFunction` (in case the optimization routine you are benchmarking makes use of the gradient or Hessian).

## Benchmark problems

For an overview of benchmarks see [Jamil and Yang (2013)](http://arxiv.org/abs/1308.4008). Unchecked functions are not implemented yet.

**Nonconvex, unconstrained:**

- [x] [Rosenbrock's function](https://en.wikipedia.org/wiki/Rosenbrock_function)
