source("CommonVar.R")

#theta_initialPH <- -0.15
#theta_1_initialPH <- -1
#x_initialPH <- 1
#x_1_initialPH <- 3
#theta_initialGP <- -0.15
#theta_1_initialGP <- -1
#x_initialGP <- 1
#x_1_initialGP <- 3

theta_initialPH <- -0.15
theta_1_initialPH <- -1
x_initialPH <- 2
x_1_initialPH <- 3
theta_initialGP <- -0.15
theta_1_initialGP <- -1
x_initialGP <- 2
x_1_initialGP <- 3

statePH <- matrix(0, timeLength, 6)
Fm = 3.5

source("PhysicalCore.R")

stateGP <- matrix(0, timeLength, 6)
stateCovGP <- matrix(0, timeLength, 4)
stateCP <- matrix(0, timeLength, 4)
stateCP[1, 1] <- theta_initialGP
stateCP[1, 2] <- theta_1_initialGP
stateCP[1, 3] <- x_initialGP
stateCP[1, 4] <- x_1_initialGP
source("GaussianProcessCore.R")
for (i in 1: timeLength) {
    print(paste("Step", as.character(i)))
    statePH[i, 1] <- theta_initialPH
    statePH[i, 2] <- theta_1_initialPH
    statePH[i, 3] <- x_initialPH
    statePH[i, 4] <- x_1_initialPH
    stateGP[i, 1] <- theta_initialGP
    stateGP[i, 2] <- theta_1_initialGP
    stateGP[i, 3] <- x_initialGP
    stateGP[i, 4] <- x_1_initialGP

    F <- Fm * sign(k1 * x_initialPH + k2 * x_1_initialPH + k3 * theta_initialPH+ k4 * theta_1_initialPH)
    statePH[i, 5] <- F
    statePH[i, 6] <- tao
    next1State <- getNextState(list(theta = theta_initialPH, theta_1 = theta_1_initialPH, x = x_initialPH, x_1 = x_1_initialPH, F = F, tao = tao))

    F <- Fm * sign(k1 * x_initialGP + k2 * x_1_initialGP + k3 * theta_initialGP+ k4 * theta_1_initialGP)
    stateGP[i, 5] <- F
    stateGP[i, 6] <- tao


    next2State <- gpNextState(list(theta = theta_initialGP, theta_1 = theta_1_initialGP, x = x_initialGP, x_1 = x_1_initialGP, F = F, tao = tao), 0)
    next3State <- getNextState(list(theta = theta_initialGP, theta_1 = theta_1_initialGP, x = x_initialGP, x_1 = x_1_initialGP, F = F, tao = tao))
    if (i != timeLength) {
        x_initialPH <- next1State$x
        x_1_initialPH <- next1State$x_1
        theta_initialPH <- next1State$theta
        theta_1_initialPH <- next1State$theta_1
        x_initialGP <- next2State$x
        x_1_initialGP <- next2State$x_1
        theta_initialGP <- next2State$theta
        theta_1_initialGP <- next2State$theta_1
        stateCovGP[i + 1, 1] <- next2State$thetaCov
        stateCovGP[i + 1, 2] <- next2State$theta_1Cov
        stateCovGP[i + 1, 3] <- next2State$xCov
        stateCovGP[i + 1, 4] <- next2State$x_1Cov
        stateCP[i + 1, 1] <- next3State$theta
        stateCP[i + 1, 2] <- next3State$theta_1
        stateCP[i + 1, 3] <- next3State$x
        stateCP[i + 1, 4] <- next3State$x_1
    }
}

save(stateGP, stateCovGP, stateCP, file = "GP_results.RData")
save(statePH, file = "Sim_Results.RData")
