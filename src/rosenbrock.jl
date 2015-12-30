export rosenbrock

function rosenbrock_f(x::Vector)
    return (1.0 - x[1])^2 + 100.0 * (x[2] - x[1]^2)^2
end

function rosenbrock_g!(x::Vector, storage::Vector)
    storage[1] = -2.0 * (1.0 - x[1]) - 400.0 * (x[2] - x[1]^2) * x[1]
    storage[2] = 200.0 * (x[2] - x[1]^2)
end

function rosenbrock_fg!(x::Vector, storage)
    d1 = (1.0 - x[1])
    d2 = (x[2] - x[1]^2)
    storage[1] = -2.0 * d1 - 400.0 * d2 * x[1]
    storage[2] = 200.0 * d2
    return d1^2 + 100.0 * d2^2
end

function rosenbrock_h!(x::Vector, storage::Matrix)
    storage[1, 1] = 2.0 - 400.0 * x[2] + 1200.0 * x[1]^2
    storage[1, 2] = -400.0 * x[1]
    storage[2, 1] = -400.0 * x[1]
    storage[2, 2] = 200.0
end

rosenbrock = TwiceDifferentiableFunction(rosenbrock_f,rosenbrock_g!,rosenbrock_fg!,rosenbrock_h!)
