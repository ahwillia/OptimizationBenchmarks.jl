VERSION >= v"0.4.0-dev+6521" && __precompile__(true)

module OptimizationBenchmarks

# implemented benchmarks are kept in this list
benchmark_list = [
	:rosenbrock,
	:ackley,
	:beale,
	:bukin6
]

# types provided for problems and solutions
include("types.jl")

# functions to check solution to benchmark problems
include("check_solution.jl")

## Benchmark Problems ##

# test functions (not motivated by applications)
include("testfunc/rosenbrock.jl")
include("testfunc/ackley.jl")
include("testfunc/beale.jl")
include("testfunc/bukin6.jl")

# machine learning / stats benchmarks
include("statbenchmarks/lasso.jl")
include("statbenchmarks/nnls.jl")

end
