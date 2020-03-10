### Load R scripts with optimizers and cost functions

source("optimizers.r")
source("cost.r")

### Load data, standardize covariate and create design matrix

## Load CSV file
simulated_data <- read.csv("simulated_data.csv", header=TRUE)

## Standardize covariate
simulated_data$covariate <- scale(simulated_data$covariate)

## Number of data points
ndata <- nrow(simulated_data)

## Number of linear regression parameters, including intercept
npars <- 2

## Create design matrix X, including a first column of ones for intercept 

X<-cbind(rep(1, ndata),simulated_data$covariate) 
### Fit a linear regression model to the data
lm_out <- lm(y~covariate, data=simulated_data)

### Run optimization algorithms

## Initial values of parameters, common across optimization algorithms
theta0 <- c(7, -8)

## Gradient descent (GD)

# GD: learning rate

a<-0.2
# GD: number of iterations
niters <- 100

# Run GD  
gd_out <- gd(lmf, lmgrad, simulated_data$y, X, theta0, npars, ndata, a, niters)



## Stochastic gradient descent (SGD)

# SGD: learning rate

a <-0.2
# SGD: number of iterations
niters <- 100

# SGD: number of subsamples per iteration
nsubsamples <- 100

# Run SGD 
sgd_out <- sgd(lmf, lmgrad, simulated_data$y, X, theta0, npars, ndata, a, niters,nsubsamples)




### save design matrix X to file "answer1a.csv"

write.table(X, file="answer1a.csv", row.names=FALSE, col.names=FALSE, sep=",")



### save parameter estimates to file "answer1b.csv"

theta_estimates <- cbind(
  LM=as.vector(lm_out$coefficients),
  GD=as.vector(tail(gd_out$theta, n=1)),
  SGD=as.vector(tail(sgd_out$theta, n=1))
)

write.table(
  theta_estimates,
  file="answer1b.csv",
  row.names=FALSE,
  col.names=TRUE,
  sep=",",
  quote=FALSE
)


### save last values of cost function to file "answer1c.csv"

final_cost_values <- cbind(
  GD=tail(gd_out$cost, n=1),
  SGD=tail(sgd_out$cost, n=1)
)

write.table(
  final_cost_values,
  file="answer1c.csv",
  row.names=FALSE,
  col.names=TRUE,
  sep=",",
  quote=FALSE
)
### save plot of cost function to file "answer1d.pdf"
pdf(file="answer1d.pdf")
plot(gd_out$cost,type="l",col="red",xlab="iteration",ylab="cost",main="compare cost of gd and sgd",lty=1,lwd=2)
lines(sgd_out$cost,type="l",col="green",lty=1,lwd=2)
legend("topright",legend=c("gd","sgd"),col=c("red","green"),lty=c(1,1),lwd=c(2,2))

dev.off()
### save phase plot of parameter theta_0 vs parameter theta_1 to file "answer1e.pdf"
pdf(file="answer1e.pdf")
gd_out$theta
sgd_out$theta
plot(y=gd_out$theta[,1],x=gd_out$theta[,2],ylim=c(-1,8),xlim=c(-8,2),type="l",col="red",ylab="theta0",xlab="theta1",main="compare two optimizers' parameters: theta0 and theta1 in gd and sgd",lty=1,lwd=2)
lines(y=sgd_out$theta[,1],x=sgd_out$theta[,2],type="l",col="green",lty=1,lwd=2)

legend("topright",legend=c("gd","sgd"),col=c("red","green"),lty=c(1,1),lwd=c(2,2))

points(y=gd_out$theta[1,1],x=gd_out$theta[1,2],col="black",cex=1)
points(y=lm_out$coefficients[1],x=lm_out$coefficients[2],col="black",cex=1)

text(y=gd_out$theta[1,1],x=gd_out$theta[1,2],col="black",labels="start point:(-8,7)",pos=4,cex=0.5)

text(y=lm_out$coefficients[1],x=lm_out$coefficients[2],col="black",labels="lm_coefficients:(1.375,-0.933)",pos=3,cex=0.5)

dev.off()





