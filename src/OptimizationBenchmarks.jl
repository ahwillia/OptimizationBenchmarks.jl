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

# nonconvex, smooth, unconstrained
include("rosenbrock.jl")
include("ackley.jl")
include("beale.jl")
include("bukin6.jl")

end
