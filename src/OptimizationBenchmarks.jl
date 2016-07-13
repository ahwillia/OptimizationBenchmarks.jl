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

# Test function types
include("testfuncs.jl")
export Ackley,
       Rosenbrock

# functions
export objective,
       solution,
       initialize,
       check_solution

# types provided for problems and solutions
include("autodiff.jl")

# common util functions for all problems
include("common.jl")

# machine learning / stats benchmarks
#include("statbenchmarks/sparse_regression.jl")
#include("statbenchmarks/nnls.jl")


end
