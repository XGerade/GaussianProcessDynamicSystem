source("PhysicalCore.R")
source("CommonVar.R")

x.data <- matrix(0, (6 * 9 * 6 * 7 * numForces), 6)
y.data <- matrix(0, (6 * 9 * 6 * 7 * numForces), 4)

theta_initial_test = c(-1, -0.6, -0.2, 0.2, 0.6, 1)
theta_1_initial_test = c(-4, -3, -2, -1, 0, 1, 2, 3, 4)
x_initial_test = c(-1, 0, 1, 2, 3, 4)
x_1_initial_test = c(-3, -2, -1, 0, 1, 2, 3)
base = 0
for (Fm in 1 : numForces)
for (theta_initial in theta_initial_test)
for (theta_1_initial in theta_1_initial_test)
for (x_initial in x_initial_test)
for (x_1_initial in x_1_initial_test) {
#Original State of the system
    tao = 0.02
    base <- base + 1
    x.data[base, 1] <- theta_initial + rnorm(1, 0, 0.001)
    x.data[base, 2] <- theta_1_initial + rnorm(1, 0, 0.001)
    x.data[base, 3] <- x_initial + rnorm(1, 0, 0.001)
    x.data[base, 4] <- x_1_initial + rnorm(1, 0, 0.001)

    F <- Fm * sign(k1 * x_initial+ k2 * x_1_initial+ k3 * theta_initial+ k4 * theta_1_initial)
    x.data[base, 5] <- F
    x.data[base, 6] <- tao

    nextState <- getNextState(list(theta = theta_initial, theta_1 = theta_1_initial, x = x_initial, x_1 = x_1_initial, F = F, tao = tao))
    
    y.data[base, 1] <- nextState$theta + rnorm(1, 0, 0.001)
    y.data[base, 2] <- nextState$theta_1 + rnorm(1, 0, 0.001)
    y.data[base, 3] <- nextState$x + rnorm(1, 0, 0.001)
    y.data[base, 4] <- nextState$x_1 + rnorm(1, 0, 0.001)
}

#calculate covariance matrix for time saving
source("GaussianProcessRegression.R")
K.xx <- calculateCovariance(x.data, x.data)


save(x.data, y.data, K.xx, file = "FakedModelData.RData")
