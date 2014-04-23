source("CommonVar.R")
source("PhysicalCore.R")
source("GaussianProcessCore.R")
load("ModelData.RData")

theta_initial <- runif(1, -0.1, 0.1)
theta_1_initial <- runif(1, -0.5, 0.5)
x_initial <- runif(1, 0, 5)
x_1_initial <- runif(1, 0, 1)

timeLength = 600

state <- matrix(0, timeLength, 6)
SSE <- matrix(0, timeLength)

state[1, 1] <- theta_initial
state[1, 2] <- theta_1_initial
state[1, 3] <- x_initial
state[1, 4] <- x_1_initial

for (i in 1: timeLength) {
    print(paste("Step", as.character(i)))
    minF = 0
    minError = Inf
    predictState = 0
    for (F in -5:5) {
        nextGPState <- gpNextState(list(theta = state[i,1], theta_1 = state[i,2], x = state[i,3], x_1 = state[i,4], F=F, tao = tao), x.data, y.data, K.xx);
        tempError <- abs(nextGPState$x_1) + abs(nextGPState$theta) + abs(nextGPState$theta_1)
        if ((abs(nextGPState$theta) < 1)&&(tempError < minError)) {
            minError = tempError
            minF = F
            predictState <- nextGPState
        }
    }

    nextState <- getNextState(list(theta = state[i,1], theta_1 = state[i,2], x = state[i,3], x_1 = state[i,4], F=minF, tao = tao))

    if (abs(nextState$theta) >= 1) break
    if (i != timeLength) {
        state[i + 1, 1] <- nextState$theta
        state[i + 1, 2] <- nextState$theta_1
        state[i + 1, 3] <- nextState$x
        state[i + 1, 4] <- nextState$x_1

        SSE[i] <- getError(predictState, nextState)
        if (SSE[i] > 0.001) {
            x.data = rbind(x.data, c(state[i,1], state[i,2], state[i,3], state[i,4], minF, tao))
            y.data = rbind(y.data, c(state[i+1,1], state[i+1,2], state[i+1,3], state[i+1,4]))
            K.xx <- calculateCovariance(x.data, x.data)
        }
        print(paste("  To state", as.character(state[i+1,1])," ", as.character(state[i+1,2]), " ", as.character(state[i+1,4])));
    }
}

save(state,timeLength,SSE,file = "Sim_Results.RData")
