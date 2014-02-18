load("Simulate_Results.RData")

source("GPRegression.R")

tao = 0.02

k1 = -1
k2 = -1
k3 = 1
k4 = -0.1

theta_initial <- -0.15
theta_1_initial <- -1
x_initial <- 1
x_1_initial <- 3

timeLength <- 300
state <- matrix(0, timeLength, 5)
sigma.squared1 = 0.01
sigma.squared2 = 0.01
Fm = 2.5
#K.xx <- calculateCovariance(x.data, x.data)
for (i in 1: timeLength) {
    print(i)
    state[i, 1] <- theta_initial
    state[i, 2] <- theta_1_initial
    state[i, 3] <- x_initial
    state[i, 4] <- x_1_initial

    F <- Fm * sign(k1 * x_initial+ k2 * x_1_initial+ k3 * theta_initial+ k4 * theta_1_initial)
    state[i, 5] <- F

    results1 <- GP.reg(x.data, theta_2_out, matrix(state[i,], 1, 5), sigma.squared1, K.xx)
    theta_2 <- results1$post.mean[1]

    results2 <- GP.reg(x.data, x_2_out, matrix(state[i,], 1, 5), sigma.squared2, K.xx)
    x_2 <- results2$post.mean[1]

    x_initial <- x_initial + tao * x_1_initial
    x_1_initial <- x_1_initial + tao * x_2
    theta_initial <- theta_initial + tao * theta_1_initial
    theta_1_initial <- theta_1_initial + tao * theta_2
}

save(state, file = "GP_Results.RData")
