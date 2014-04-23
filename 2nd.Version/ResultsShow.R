source("CommonVar.R")
#load("Sim_Results.RData")
#load("GP_Results.RData")
load("[1-9 3.5]GP_results.RData")
load("[1-9 3.5]Sim_Results.RData")

timeLength = dim(stateGP)[1]
timeLength = 300
statePH = statePH[1:300,]
stateGP = stateGP[1:300,]
stateCP = stateCP[1:300,]
par(mfrow=c(2,2))

plot(NULL, col = 'white', main = 'state of theta', xlim = c(0, timeLength * 0.02), ylim = c(min(c(stateGP[,1], statePH[,1])), max(c(stateGP[,1],statePH[,1]))), xlab = 'time', ylab = 'theta')

time <- seq(from = 0, to = timeLength * 0.02 - 0.02, by = 0.02)

points(time, statePH[, 1], col = 'green', type = 'l')
points(time, stateGP[, 1] + stateCovGP[, 1], col = 'grey', type = 'l')
points(time, stateGP[, 1] - stateCovGP[, 1], col = 'grey', type = 'l')
points(time, stateCP[, 1], col = 'blue', type = 'l')
points(time, stateGP[, 1], col = 'red', type = 'l')

plot(NULL, col = 'white', main = 'state of theta\'', xlim = c(0, timeLength * 0.02), ylim = c(min(c(stateGP[,2], statePH[,2])), max(c(stateGP[,2], statePH[,2]))), xlab = 'time', ylab = 'theta\'')

time <- seq(from = 0, to = timeLength * 0.02 - 0.02, by = 0.02)

points(time, statePH[, 2], col = 'green', type = 'l')
points(time, stateGP[, 2] + stateCovGP[, 2], col = 'grey', type = 'l')
points(time, stateGP[, 2] - stateCovGP[, 2], col = 'grey', type = 'l')
points(time, stateCP[, 2], col = 'blue', type = 'l')
points(time, stateGP[, 2], col = 'red', type = 'l')

plot(NULL, col = 'white', main = 'state of x', xlim = c(0, timeLength * 0.02), ylim = c(min(c(stateGP[,3], statePH[,3])), max(c(stateGP[,3], statePH[,3]))), xlab = 'time', ylab = 'x')

time <- seq(from = 0, to = timeLength * 0.02 - 0.02, by = 0.02)

points(time, statePH[, 3], col = 'green', type = 'l')
points(time, stateGP[, 3] + stateCovGP[, 3], col = 'grey', type = 'l')
points(time, stateGP[, 3] - stateCovGP[, 3], col = 'grey', type = 'l')
points(time, stateCP[, 3], col = 'blue', type = 'l')
points(time, stateGP[, 3], col = 'red', type = 'l')

plot(NULL, col = 'white', main = 'state of x\'', xlim = c(0, timeLength * 0.02), ylim = c(min(c(stateGP[,4], statePH[,4])), max(c(stateGP[,4], statePH[,4]))), xlab = 'time', ylab = 'x\'')

time <- seq(from = 0, to = timeLength * 0.02 - 0.02, by = 0.02)

points(time, statePH[, 4], col = 'green', type = 'l')
points(time, stateCP[, 4], col = 'blue', type = 'l')
points(time, stateGP[, 4], col = 'red', type = 'l')
points(time, stateGP[, 4] + stateCovGP[, 4], col = 'grey', type = 'l')
points(time, stateGP[, 4] - stateCovGP[, 4], col = 'grey', type = 'l')
