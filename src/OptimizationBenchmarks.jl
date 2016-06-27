VERSION >= v"0.4.0-dev+6521" && __precompile__(true)

module OptimizationBenchmarks

# Abstract types
abstract BenchmarkProblem

"""
Benchmarks whose objective functions are fixed and known in closed form (e.g. Rosenbrock)
"""
abstract TestFuncBenchmark <: BenchmarkProblem

"""
Benchmarks that depend on synthetic data (e.g. sparse regression - LASSO)
"""
abstract StatBenchmark <: BenchmarkProblem

"""
Solution to a benchmark problem
"""
immutable BenchmarkSolution{T<:Real}
    x::AbstractArray{T}
    f::T
end

# TODO: Move to LearnBase
abstract Loss
type SquaredLoss <: Loss end
value(::SquaredLoss,x,y) = sum((x-y).^2)

# Test function types
include("testfuncs.jl")
export Ackley,
       Rosenbrock

# functions
export objective,
       solution,
       initialize,
       check_solution

# # Test functions
# export Ackley,
#        Rosenbrock,
#        Beale,
#        Bukin6

# # Statistical problems
# export Lasso,
#        NNLS,
#        LogisticReg

# types provided for problems and solutions
include("autodiff.jl")

# common util functions for all problems
include("common.jl")

## Benchmark Problems ##

# test functions (not motivated by applications)
#include("testfunc/beale.jl")
#include("testfunc/bukin6.jl")

# machine learning / stats benchmarks
#include("statbenchmarks/sparse_regression.jl")
#include("statbenchmarks/nnls.jl")

end
