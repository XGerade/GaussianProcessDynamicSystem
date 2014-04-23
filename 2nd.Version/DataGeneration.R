source("PhysicalCore.R")
source("CommonVar.R")

x.data <- matrix(0, dataSize, 6)
y.data <- matrix(0, dataSize, 4)
base = 0
for (Fm in ForcesStart : ForcesEnd) {
#Original State of the system
    theta_initial <- -0.15
    theta_1_initial <- -1
    x_initial <- 1
    x_1_initial <- 3
    theta_2 <- 0
    x_2 <- 0
    tao = 0.02

    for (i in 1 : numTime) {
        base <- base + 1
        x.data[base, 1] <- theta_initial + rnorm(1, 0, 0.001)
        x.data[base, 2] <- theta_1_initial + rnorm(1, 0, 0.001)
        x.data[base, 3] <- x_initial + rnorm(1, 0, 0.001)
        x.data[base, 4] <- x_1_initial + rnorm(1, 0, 0.001)

        F <- Fm * sign(k1 * x_initial+ k2 * x_1_initial+ k3 * theta_initial+ k4 * theta_1_initial)
        x.data[base, 5] <- F
        x.data[base, 6] <- tao

        nextState <- getNextState(list(theta = theta_initial, theta_1 = theta_1_initial, x = x_initial, x_1 = x_1_initial, F = F, tao = tao))

        x_initial <- nextState$x
        x_1_initial <- nextState$x_1
        theta_initial <- nextState$theta
        theta_1_initial <- nextState$theta_1
        
        y.data[base, 1] <- theta_initial + rnorm(1, 0, 0.001)
        y.data[base, 2] <- theta_1_initial + rnorm(1, 0, 0.001)
        y.data[base, 3] <- x_initial + rnorm(1, 0, 0.001)
        y.data[base, 4] <- x_1_initial + rnorm(1, 0, 0.001)
    }
}

#calculate covariance matrix for time saving
source("GaussianProcessRegression.R")
K.xx <- calculateCovariance(x.data, x.data)


save(x.data, y.data, K.xx, file = "ModelData.RData")
