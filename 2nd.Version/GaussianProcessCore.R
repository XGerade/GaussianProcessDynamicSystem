load("ModelData.RData")
source("CommonVar.R")
source("GaussianProcessRegression.R")

gpNextState <- function(inState) {

    theta_initial = inState$theta
    theta_1_initial = inState$theta_1
    x_initial = inState$x
    x_1_initial = inState$x_1
    F = inState$F
    tao = inState$tao

    xInput = matrix(c(theta_initial, theta_1_initial, x_initial, x_1_initial, F, tao), 1, 6)
    theta <- GP.reg(x.data, y.data[, 1], xInput, sigma.squared, K.xx)
    theta_1 <- GP.reg(x.data, y.data[, 2], xInput, sigma.squared, K.xx)
    x <- GP.reg(x.data, y.data[, 3], xInput, sigma.squared, K.xx)
    x_1 <- GP.reg(x.data, y.data[, 4], xInput, sigma.squared, K.xx)

    out <- list(x = x$post.mean[1], xCov = x$post.var[1], x_1 = x_1$post.mean[1], x_1Cov = x_1$post.var[1], theta = theta$post.mean[1], thetaCov = theta$post.var[1], theta_1 = theta_1$post.mean[1], theta_1Cov = theta_1$post.var[1])
    return(out)
}

