function bukin6_f(x::Vector)
	term1 = 100 * sqrt(abs(x[2] - 0.01*x[1]^2))
	term2 = 0.01 * abs(x[1]+10)
	return term1 + term2
end

bukin6 = auto_twice_diff_function(bukin6_f)

solution(::Type{Val{:bukin6}}; d=2) = BenchmarkSolution([-10.0,1.0],0.0)
