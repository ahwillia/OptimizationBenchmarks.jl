export nnls

"""
A,X,B = nnls(m,n,k,density,noise,seed)

Generates a non-negative least-squares problem:
    minimize 1/2*|| A*X - B ||_2^2 s.t. X ≥ 0

    A ∈ R(m × k), X ∈ R(k × n), B ∈ R(k × n)
"""
function nnls(;
    m::Integer = 1000, # number of observations
    k::Integer = 1000, # number of unknowns per observation dimension
    n::Integer = 1,    # dimension of observations
    density = 0.5,     # fraction of zeros in X
    noise = 0.0,       # added noise to B
    seed::Int=0        # random seed (to skip this, set seed to be negative)
    )

    # set seed of random number generator
    if seed >= 0
        srand(seed)
    end

    # generate A and X
    A = randn(m,k)
    X = abs(sprand(k,n,density));

    # generate B, with noise
    B = A*X + sqrt(noise)*randn(k,n)

    # Return data and regularization parameter
    return A,X,B
end
