source("CommonVar.R")

getNextState <- function(inState) {
    theta_initial = inState$theta
    theta_1_initial = inState$theta_1
    x_initial = inState$x
    x_1_initial = inState$x_1
    F = inState$F
    tao = inState$tao
    theta_2 <- (g * sin(theta_initial) + cos(theta_initial) * ((-F - Mp * l * theta_1_initial ^ 2 * sin(theta_initial)) / (Mp + Mc))) / (l * (4 / 3 - Mp * cos(theta_initial) ^ 2 / (Mc + Mp)))
    x_2 <- (F + Mp * l * (theta_1_initial ^ 2 * sin(theta_initial) - theta_2 * cos(theta_initial))) / (Mp + Mc)
    x <- x_initial + tao * x_1_initial
    x_1 <- x_1_initial + tao * x_2
    theta <- theta_initial + tao * theta_1_initial
    theta_1 <- theta_1_initial + tao * theta_2
    out <- list(x = x, x_1 = x_1, theta = theta, theta_1 = theta_1)
    return(out)
}
