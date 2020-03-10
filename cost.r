### Cost functions for linear regression

## Cost function for linear regression

lmf <- function(y, X, theta, ndata) {
  sum((X%*%theta-y)^2)/(2*ndata)
}

## Gradient of cost function for linear regression

lmgrad <- function(y, X, theta, ndata){
  t(X)%*%(X%*%theta-y)/ndata
}
