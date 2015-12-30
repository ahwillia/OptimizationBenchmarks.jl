import ForwardDiff
import Base.show

## All smooth objective functions are DifferentiableFunctions
import Optim: DifferentiableFunction, TwiceDifferentiableFunction

function auto_diff_function(f::Function)
    # Autodiff for gradient/hessian
    g_! = ForwardDiff.gradient(f; mutates=true)
    
    # Optim expects storage vector second
    function g!(x::Array, storage::Array)
        g_!(storage, x)
        return
    end
    function fg!(x::Array, storage::Array)
        g_!(storage, x)
        return f(x)
    end
    return DifferentiableFunction(f, g!, fg!)
end

function auto_twice_diff_function(f::Function)
    # Autodiff for gradient/hessian
    g_! = ForwardDiff.gradient(f; mutates=true)
    h_! = ForwardDiff.hessian(f; mutates=true)
    
    # Optim expects storage vector second
    function g!(x::Vector, storage::Vector)
        g_!(storage,x)
        return
    end
    function fg!(x::Vector, storage::Vector)
        g_!(storage,x)
        return f(x)
    end
    function h!(x::Vector, storage::Matrix)
        h_!(storage,x)
        return
    end
    return TwiceDifferentiableFunction(f, g!, fg!, h!)
end


## Holds solution to benchmark problems
immutable BenchmarkSolution
	x::Vector{Float64}
	f::Float64
end

function Base.show(io::IO, sol::BenchmarkSolution)
    @printf io "Solution to optimization benchmark:\n"
    if length(join(sol.x, ",")) < 40
        @printf io " * Minimum: [%s]\n" join(sol.x, ",")
    else
        @printf io " * Minimum: [%s, ...]\n" join(sol.x[1:2], ",")
    end
    @printf io " * Value of Function at Minimum: %f\n" sol.f
    return
end
