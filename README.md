# OptimizationBenchmarks.jl
Some benchmark optimization problems for testing new algorithms

## Example

```
using OptimizationBenchmarks
using Optim
@elapsed optimize(rosenbrock, [0.0, 0.0], method = :bfgs)
```

## Details

* Differentiable objective functions (e.g. `rosenbrock`) are provided as `TwiceDifferentiableFunction` (in case the optimization routine you are benchmarking makes use of the gradient or Hessian).
