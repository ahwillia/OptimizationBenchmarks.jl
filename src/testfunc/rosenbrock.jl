export rosenbrock, solution

function rosenbrock_f(x::Vector)
    return (1.0 - x[1])^2 + 100.0 * (x[2] - x[1]^2)^2
end

rosenbrock = auto_twice_diff_function(rosenbrock_f)

solution(::Type{Val{:rosenbrock}}; d=2) = BenchmarkSolution([1.0,1.0],0.0)
