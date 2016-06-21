export beale

# source: http://www.sfu.ca/~ssurjano/beale.html
beale_f(x::Vector) = (1.5 - x[1] + x[1]*x[2])^2 + (2.25 - x + x[1]*(x[2]^2))^2 + (2.625 - x[1] + x[1]*(x[2]^3))^2

beale = auto_twice_diff_function(beale_f)

solution(::Type{Val{:beale}}; d=2) = BenchmarkSolution([3.0,0.5],0.0)
