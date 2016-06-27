## ----- ACKLEY ----- ##
type Ackley <: TestFuncBenchmark
    n::Int # number of optimization variables
end
Ackley() = Ackley(2)

# source: http://julialang.org/blog/2015/10/auto-diff-in-julia/
function f_ackley(x)
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
(::Ackley)(x) = f_ackley(x)

objective(::Ackley) = auto_twice_diff_function(f_ackley)
dimensionality(p::Ackley) = p.n
solution(p::Ackley) = BenchmarkSolution(zeros(p.n),0.0)

## ----- ROSENBROCK ----- ##
type Rosenbrock <: TestFuncBenchmark end

f_rosenbrock(x) = (1.0 - x[1])^2 + 100.0 * (x[2] - x[1]^2)^2
(::Rosenbrock)(x) = f_rosenbrock(x)

objective(::Rosenbrock) = auto_twice_diff_function(f_rosenbrock)
dimensionality(::Rosenbrock) = 2
solution(p::Rosenbrock) = BenchmarkSolution(ones(2),0.0)

## ----- BEALE ----- ##
type Beale <: TestFuncBenchmark end

# source: http://www.sfu.ca/~ssurjano/beale.html
f_beale(x) = (1.5 - x[1] + x[1]*x[2])^2 + (2.25 - x + x[1]*(x[2]^2))^2 + (2.625 - x[1] + x[1]*(x[2]^3))^2
(::Beale)(x) = f_beale(x)

objective(::Beale) = auto_twice_diff_function(f_beale)
dimensionality(::Beale) = 2
solution(::Beale) = BenchmarkSolution([3.0,0.5],0.0)

## ----- BUKIN6 ----- ##
type Bukin6 <: TestFuncBenchmark end

function f_bukin6(x)
    term1 = 100 * sqrt(abs(x[2] - 0.01*x[1]^2))
    term2 = 0.01 * abs(x[1]+10)
    return term1 + term2
end
(::Bukin6)(x) = f_bukin6(x)

objective(::Bukin6) = auto_twice_diff_function(bukin6_f)
dimensionality(::Bukin6) = 2
solution(::Bukin6) = BenchmarkSolution([-10.0,1.0],0.0)
