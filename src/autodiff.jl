import ForwardDiff
import Base.show

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

