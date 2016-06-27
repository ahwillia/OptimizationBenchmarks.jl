import Optim: MultivariateOptimizationResults

## ---- Initializing Solver ---- ##

function initialize(p::BenchmarkProblem; seed::Integer=-1)
    seed < 0 ? srand() : srand(seed)
    return randn(dimensionality(p))
end

## ---- Checking Solutions ---- ##

function check_solution(
        benchmark::BenchmarkProblem,
        result::MultivariateOptimizationResults;
        kwargs...
    )
    fmin = result.f_minimum
    xmin = result.minimum
    check_solution(solution(benchmark),fmin,xmin;kwargs...)
end
check_solution(r::MultivariateOptimizationResults,b::BenchmarkProblem) = check_solution(b,r;kwargs...)

function check_solution(
    sol::BenchmarkSolution,
    fmin::Float64,
    xmin::Vector;
    tol::Float64=1e-4
    )

    nvars = length(xmin)

    length(xmin) != length(sol.x) && error("xmin length does not match solution")

    f_resid = abs(sol.f - fmin)
    x_resid = vecnorm(sol.x - xmin)/sqrt(length(xmin))

    f_mismatch = f_resid > tol
    x_mismatch = x_resid > tol
    
    f_mismatch && warn("Objective function does not match solution.")
    x_mismatch && warn("Optimization variables do not match solution.")
    
    !(f_mismatch || x_mismatch) && info("Solution matches.")

    return f_resid,x_resid
end

## ---- Display ---- ##

function Base.show(io::IO, sol::BenchmarkSolution)
    @printf io "Solution to optimization benchmark:\n"
    if length(join(sol.x, ",")) < 40
        @printf io " * Minimum: [%s]\n" join(sol.x, ",")
    else
        @printf io " * Minimum: [%s, ...]\n" join(sol.x[1:2], ",")
    end
    @printf io " * Objective function at minimum: %f\n" sol.f
    return
end

