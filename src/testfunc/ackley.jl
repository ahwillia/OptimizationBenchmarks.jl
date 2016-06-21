export ackley

# source: http://julialang.org/blog/2015/10/auto-diff-in-julia/
function ackley_f(x)
    a, b, c = 20.0, -0.2, 2.0*π
    len_recip = inv(length(x))
    sum_sqrs = zero(eltype(x))
    sum_cos = sum_sqrs
    for i in x
        sum_cos += cos(c*i)
        sum_sqrs += i^2
    end
    return (-a * exp(b * sqrt(len_recip*sum_sqrs)) -
            exp(len_recip*sum_cos) + a + e)
end

ackley = auto_twice_diff_function(ackley_f)

solution(::Type{Val{:ackley}}; d=2) = BenchmarkSolution(zeros(d),0.0)

