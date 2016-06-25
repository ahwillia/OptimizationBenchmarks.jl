using Base.Test
using OptimizationBenchmarks
import Optim

# Optim should solve rosenbrock
result = Optim.optimize(rosenbrock, [0.0,0.0], Optim.BFGS())
check_solution(:rosenbrock, result.f_minimum, result.minimum)

# True solution of :rosenbrock
check_solution(:rosenbrock, 0.0, [1.0,1.0])

# Should throw an error if provided solution is wrong
@test_throws ErrorException check_solution(:rosenbrock, 0.1, [1.0,1.0])
@test_throws ErrorException check_solution(:rosenbrock, 0.0, [1.1,1.0])
