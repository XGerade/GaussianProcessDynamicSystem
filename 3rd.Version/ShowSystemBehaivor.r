source("PhysicalCore.R")
source("CommonVar.R")

timeLength = 600

state <- matrix(0, timeLength, 4)

#Fm = 5
#theta_initial <- runif(1, -0.1, 0.1)
#theta_1_initial <- runif(1, -0.5, 0.5)
#x_initial <- runif(1, 0, 5)
#x_1_initial <- runif(1, 0, 1)

Fm = 1
theta_initial <- 0.5
theta_1_initial <- 0.2
x_initial <- 4
x_1_initial <- -10

theta_2 <- 0
x_2 <- 0
tao = 0.02

state[1, 1] <- theta_initial
state[1, 2] <- theta_1_initial
state[1, 3] <- x_initial
state[1, 4] <- x_1_initial

for (i in 1 : (timeLength - 1)) {
    F <- Fm * sign(k1 * state[i, 3] + k2 * state[i, 4] + k3 * state[i, 1] + k4 * state[i, 2])

    nextState <- getNextState(list(theta = state[i, 1], theta_1 = state[i, 2], x = state[i, 3], x_1 = state[i, 4], F = F, tao = tao))

    state[i + 1, 3] <- nextState$x
    state[i + 1, 4] <- nextState$x_1
    state[i + 1, 1] <- nextState$theta
    state[i + 1, 2] <- nextState$theta_1
}

save(state, file = "PhysicalResult.RData")
