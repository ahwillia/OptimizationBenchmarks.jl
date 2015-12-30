# function that provides solution to each benchmark
export solution, check_solution
function solution(benchmark::Symbol; kwargs...)
	if benchmark in benchmark_list
		return solution(Val{benchmark}; kwargs...)
	else
		throw(ArgumentError("Unknown benchmark: $benchmark"))
	end
end

function check_solution(
	benchmark::Symbol,
	fmin::Float64,
	xmin::Vector;
	tol::Float64=1e-4
	)

	sol = solution(benchmark, d=length(xmin))

	if abs(sol.f - fmin) > tol
		error("Minimum of objective function does not match solution.")
	end

	for i = 1:length(xmin)
		if abs(sol.x[i] - xmin[i]) > tol
			error("Optimization variable with index $i does not match solution.")
		end
	end
end
