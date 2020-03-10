# Big_data_analysis
stochastic optimization-GD and SGD
# Algorithm
This project outlines the stochastic optimization methods appearing in the project. Gradient
descent (GD) is the starting point for stochastic optimization.

Gradient descent (GD) 
Let J(θ,D) be a cost function, where θ is an nθ-length parameter vector and D a dataset of nd samples. Moreover, let ∇θJ(θ,D) be the gradient of cost function.

J(θ) := J(θ,D) with respect to θ. The approximation θ(k) of θ at step k of GD given the approximation θ(k−1) of θ at step k-1 is defined as

θ(k) := θ(k−1) − a∇θJ(θ(k−1),D)        (1)

where the learning rate a is a positive real number. In the case of a linear regression model, the data are set to D := {X, y}, where X is the nd * nθ design matrix and y is the nd-length output vector associated with linear regression.

Stochastic gradient descent (SGD) For a big data set D consisting of a large number nd of data points, the evaluation of the gradient ∇θJ(θ,D) can be computationally expensive.

To reduce the computational complexity of GD, stochastic gradient descent (SGD) samples an s-size subset D_s(k) of the data D at step k and evaluates the gradient ∇θJ(θ,D_s(k)) using the subset D_s(k).

θ(k) := θ(k−1) − a∇θJ(θ(k−1),D_s(k)    (2)
