### Gradient descent given a cost function f and its gradient grad

gd <- function(f, grad, y, X, theta0, npars, ndata, a, niters) {
  theta <- matrix(data=NA, nrow=niters, ncol=npars)
  cost <- vector(mode="numeric", length=niters)
  
  theta[1, ] <- theta0
  cost[1] <- f(y, X, theta0, ndata)
  
  for (i in 2:niters) {
   
      
      theta[i, ] <- theta[i-1,]-a*lmgrad(y,X,theta[i-1,],ndata)
      cost[i] <- lmf(y,X,theta[i,],ndata)
  }
  
  return(list(theta=theta, cost=cost))
}

### Stochastic gradient descent given a cost function f and its gradient grad

sgd <- function(f, grad, y, X, theta0, npars, ndata, a, niters, nsubsamples) {
  theta <- matrix(data=NA, nrow=niters, ncol=npars)
  cost <- vector(mode="numeric", length=niters)
  
  subsamples <- sample(ndata, nsubsamples, replace=FALSE)
  
  theta[1, ] <- theta0
  cost[1] <- f(y[subsamples], X[subsamples, ], theta0, nsubsamples)
  
  for (i in 2:niters) {
    subsamples <- sample(ndata, nsubsamples, replace=FALSE)
    
    theta[i, ] <- theta[i-1,]-a*grad(y[subsamples],X[subsamples, ],theta[i-1,],nsubsamples) 
    cost[i] <-f(y[subsamples],X[subsamples, ],theta[i,],nsubsamples) 
  }
  
  return(list(theta=theta, cost=cost))
}

