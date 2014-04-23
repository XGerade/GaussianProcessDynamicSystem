load("Sim_Results.RData")

#load("PhysicalResult.RData")

timelength = dim(state)[1]
par(mfrow=c(2,2))
time <- seq(from = 0, to = timeLength * 0.02 - 0.02, by = 0.02)

plot(NULL, col = 'white', main = 'state of theta', xlim = c(0, timeLength * 0.02), ylim = c(min(state[,1]), max(state[,1])), xlab = 'time(s)', ylab = 'theta')
points(time, state[, 1], col = 'red', type = 'l')

plot(NULL, col = 'white', main = 'state of theta\'', xlim = c(0, timeLength * 0.02), ylim = c(min(state[,2]), max(state[,2])), xlab = 'time(s)', ylab = 'theta\'')
points(time, state[, 2], col = 'green', type = 'l')

plot(NULL, col = 'white', main = 'state of x', xlim = c(0, timeLength * 0.02), ylim = c(min(state[,3]), max(state[,3])), xlab = 'time(s)', ylab = 'x')
points(time, state[, 3], col = 'blue', type = 'l')

plot(NULL, col = 'white', main = 'state of x\'', xlim = c(0, timeLength * 0.02), ylim = c(min(state[,4]), max(state[,4])), xlab = 'time(s)', ylab = 'x\'')
points(time, state[, 4], col = 'purple', type = 'l')

time <- seq(from = 0, to = (timeLength - 1) * 0.02 - 0.02, by = 0.02)
plot(NULL, col = 'white', main = 'Sum of Squared Error', xlim = c(0, timeLength * 0.02), ylim = c(0, max(SSE)), xlab = 'time(s)', ylab = 'SSE')
points(time, SSE, col = 'red', type = 'l')
