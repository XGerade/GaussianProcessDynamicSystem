source("CommonVar.R")

theta_initialPH <- -0.15
theta_1_initialPH <- -1
x_initialPH <- 1
x_1_initialPH <- 3

theta_SE <- 0
theta_1_SE <- 0
x_SE <- 0
x_1_SE <- 0

Fm = 4.5

source("PhysicalCore.R")
source("GaussianProcessCore.R")
for (i in 1: 200) {
    print(paste("Step", as.character(i)))

    F <- Fm * sign(k1 * x_initialPH + k2 * x_1_initialPH + k3 * theta_initialPH+ k4 * theta_1_initialPH)

    next1State <- getNextState(list(theta = theta_initialPH, theta_1 = theta_1_initialPH, x = x_initialPH, x_1 = x_1_initialPH, F = F, tao = tao))
    next2State <- gpNextState(list(theta = theta_initialPH, theta_1 = theta_1_initialPH, x = x_initialPH, x_1 = x_1_initialPH, F = F, tao = tao))

    x_SE <- x_SE + (next1State$x - next2State$x) ^ 2
    x_1_SE <- x_1_SE + (next1State$x_1 - next2State$x_1) ^ 2
    theta_SE <- theta_SE + (next1State$theta - next2State$theta) ^ 2
    theta_1_SE <- theta_1_SE + (next1State$theta_1 - next2State$theta_1) ^ 2

    x_initialPH <- next1State$x
    x_1_initialPH <- next1State$x_1
    theta_initialPH <- next1State$theta
    theta_1_initialPH <- next1State$theta_1

}

print(theta_SE)
print(theta_1_SE)
print(x_SE)
print(x_1_SE)
