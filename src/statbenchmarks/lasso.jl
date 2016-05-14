import StatsBase:zscore

export lasso

# see: http://web.stanford.edu/~boyd/papers/admm/lasso/lasso_example.html

"""
lasso(m,n,density,noise,seed)

Generates synthetic data for the lasso problem:
	minimize 1/2*|| X*β - y ||_2^2 + λ || β ||_1
"""
function lasso(;
	m::Int = 1500,              # number of observations
	n::Int = 5000,              # number of features
	density::Float64 = 100.0/n, # sparsity parameter
	noise::Float64 = 0.001,     # variance of gaussian noise added to dependent vars
	seed::Int=0                 # random seed (to skip this, set seed to be negative)
	)

	# set seed of random number generator
	if seed >= 0
		srand(seed)
	end

	# generate independent variables
	X = randn(m,n);
	for i in 1:n
		X[:,i] = zscore(X[:,i]) # center and normalize each feature
	end 

	# generate sparse (true) regression coefficients
	β = sprandn(n, 1, density)

	# generate observations for dependent variable
	y = X*β + sqrt(noise)*randn(m,1)

	# Calculate a good value for λ
	λ_max = norm( X*β, Inf )
	λ = 0.1*λ_max;

	# Return data and regularization parameter
	return X,vec(y),β,λ
end
