GP.reg <- function(x.train, y, x.test, sigma.squared, K.xx){
  
  x <- x.train
  trainingSize <- dim(x)[1]
  z <- x.test

  K.xz <- calculateCovariance(x, z)
  K.zz <- calculateCovariance(z, z)
  K.zx <- t(K.xz)

  A <- K.xx + diag(sigma.squared, trainingSize)
  R <- chol(A)
  #print(R)
  b <- backsolve(R, forwardsolve(t(R), y)) 
  post.mean <- K.zx %*% b
  
  C <- forwardsolve(t(R), K.xz)
  post.var <- K.zz - t(C) %*% C
  
  out <- list(post.mean = post.mean, post.var = post.var, sigma.squared=sigma.squared)
  return(out)  
}

calculateCovariance <- function(x.1, x.2, ell = 1){

  covar <- matrix(0, dim(x.1)[1], dim(x.2)[1])
  for (i in 1: dim(x.1)[1]) {
      for (j in 1 : dim(x.2)[1]) {
          covar[i, j] <- exp(-1/(2 * ell^2) * (sum((x.1[i,] - x.2[j,])^2)))          
      }
  }  
  return(covar)
}
  




