using LearnBase
import Transformations: GeneralizedLinearTransformation
using Losses

immutable SparseRegressionBenchmark
	w::Matrix   # (1 x p) sparse matrix of regression weights
	tfm::GeneralizedLinearTransformation
	loss::Loss # TODO: turn into LearnBase.Loss
end

cannonicalloss(tfm::GeneralizedLinearTransformation)


function SparseRegressionBenchmark(
		nf=5000,             # number of features
		density=0.02,        # sparsity of weight vector
		ξ=0.001,             # observation noise
		link=(_)->nothing,   # identity by default
		loss=QuadLoss, # least-squares
		seed=nothing
	)
	seed == nothing ? srand() : srand(seed)
	w = sprandn(1, nf, density)
	SparseRegressionBenchmark(w,ξ,link,loss)
end

nfeatures(r::SparseRegressionBenchmark) = length(r.w)

"""
	X,y = rand(r::SparseRegressionBenchmark, n=1)

Generate `n` observations from the sparse regression problem
"""
function rand(r::SparseRegressionBenchmark, n::Int=1)
	p = nfeatures(r)
	X = randn(p,n)
	y = transform(r.tfm,A_mul_B(r.w, X))
	return (X,y)
end

function rand!(r::SparseRegressionBenchmark, y::Matrix)
	@assert size(y,1) == 1 # univariate response
	n = size(y,2)
	p = nfeatures(r)
	A_mul_B!(y,randn(n,p),r.w)
	transform!(y,r.tfm)
end

objective(r::SparseRegressionBenchmark, W_hat::Matrix) = value(r.loss, r.W, r.W_hat)
