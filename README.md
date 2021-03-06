# OptimizationBenchmarks.jl
Some benchmark optimization problems for testing new algorithms

## Example

```julia
using OptimizationBenchmarks
using Optim
problem = Rosenbrock()
x0 = initialize(problem; seed=1234)
@elapsed result = optimize(objective(problem), x0, method=Optim.BFGS())
check_solution(problem,result)
```

## Details

* Differentiable objective functions (e.g. `rosenbrock`) are provided as `TwiceDifferentiableFunction` (in case the optimization routine you are benchmarking makes use of the gradient or Hessian).

## Benchmark problems

### Test Functions

These are some classic benchmarks that have been constructed purely to test optimization algorithms. They are not motivated by particular applications.

For an overview of test function benchmarks see [Jamil & Yang (2013)](http://arxiv.org/abs/1308.4008) and [Surjanovic's & Bingham's Library of Simulation Experiments](http://www.sfu.ca/~ssurjano). Unchecked functions are not implemented yet.

**Nonconvex benchmarks:**

- [x] [Rosenbrock function](https://en.wikipedia.org/wiki/Rosenbrock_function)
- [x] [Ackley function](http://www.sfu.ca/~ssurjano/ackley.html)
- [x] [Beale function](http://www.sfu.ca/~ssurjano/beale.html)
- [x] [Bukin function N. 6](http://www.sfu.ca/~ssurjano/bukin6.html)

**Convex benchmarks:**

- [ ] Sphere Function
- [ ] Elongated Quadratic Valley

### Machine Learning and Statistics Benchmarks

These are benchmark problems that have been constructed with a particular application in mind. Each instance of these problems involves randomly generated data, so make sure you use the same benchmark instance when comparing algorithms.

**Smooth, convex:**
- [ ] Least-Squares Regression
- [ ] Robust Regression

**Nonsmooth, convex:**
- [x] LASSO
- [ ] Sparse Logistic Regression, l1 penalty
- [ ] [SLOPE](http://statweb.stanford.edu/~candes/papers/SLOPE.pdf)

**Nonsmooth, nonconvex:**
- [ ] Sparse PCA, l1 penalty

**Other problems:**
- [ ] [Optim.jl has some here](https://github.com/JuliaOpt/Optim.jl/blob/master/src/problems/unconstrained.jl) 
