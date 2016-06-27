using Base.Test
using OptimizationBenchmarks
using Optim

# Optim should solve rosenbrock
problem = Rosenbrock()
result = optimize(objective(problem), 1e-2*randn(2), method=BFGS())
f_resid,x_resid = check_solution(problem,result;verbose=false)
@test f_resid < 1e-6
@test x_resid < 1e-6

# True solution of :rosenbrock
f_resid,x_resid = check_solution(solution(Rosenbrock()), 0.0, [1.0,1.0]; verbose=false)
@test f_resid < 1e-6
@test x_resid < 1e-6
