using MLModels

immutable SparseRegressionBenchmark
	w::Matrix   # (1 x p) matrix of true weights
	ξ::Float64  # scale of observation noise
	link::Function # TODO: turn into LearnBase.Transformation
	loss::Loss # TODO: turn into LearnBase.Loss
end

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

nfeatures(r::SparseRegressionBenchmark) = size(r.w,p)

function rand(r::SparseRegressionBenchmark, n::Int=1)
	p = nfeatures(r)
	X = randn(n,p)
	y = map(r.link,A_mul_B(r.w, X))
	return (X,y)
end

function rand!(r::SparseRegressionBenchmark, y::Matrix)
	@assert size(y,2) == 1
	n = size(y,1)
	p = nfeatures(r)
	A_mul_B!(y,randn(n,p),r.w)
	map!(r.link,y)
end

value(r::SparseRegressionBenchmark, W_hat::Matrix) = value(r.loss, r.W, r.W_hat)
