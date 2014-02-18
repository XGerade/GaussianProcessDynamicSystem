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
x.data <- matrix(0, timeLength, 5)

l = 0.5
Mp = 0.1
Mc = 1
g = -9.81

tao = 0.02

k1 = -1
k2 = -1
k3 = 1
k4 = -0.1

for (i in 1 : timeLength) {
    x.data[i, 1] <- theta_initial
    x.data[i, 2] <- theta_1_initial
    x.data[i, 3] <- x_initial
    x.data[i, 4] <- x_1_initial

    F <- Fm * sign(k1 * x_initial+ k2 * x_1_initial+ k3 * theta_initial+ k4 * theta_1_initial)
    x.data[i, 5] <- F


    theta_2 <- (g * sin(theta_initial) + cos(theta_initial) * ((-F - Mp * l * theta_1_initial ^ 2 * sin(theta_initial)) / (Mp + Mc))) / (l * (4 / 3 - Mp * cos(theta_initial) ^ 2 / (Mc + Mp)))
    x_2 <- (F + Mp * l * (theta_1_initial ^ 2 * sin(theta_initial) - theta_2 * cos(theta_initial))) / (Mp + Mc)

    x_initial <- x_initial + tao * x_1_initial
    x_1_initial <- x_1_initial + tao * x_2
    theta_initial <- theta_initial + tao * theta_1_initial
    theta_1_initial <- theta_1_initial + tao * theta_2
}



load("simulate_results.rdata")

plot(NULL, col = 'white', main = 'state of theta', xlim = c(0, timeLength * 0.02), ylim = c(-1, 1), xlab = 'time', ylab = 'theta')

time <- seq(from = 0, to = timeLength * 0.02 - 0.02, by = 0.02)

points(time, state[,1], col = 'blue', type = 'l')
points(time, x.data[, 1], col = 'red', type = 'l')


load("simulate_results.rdata")

plot(NULL, col = 'white', main = 'State of X', xlim = c(0, timeLength * 0.02), ylim = c(-5, 5), xlab = 'time', ylab = 'x')

time <- seq(from = 0, to = timeLength * 0.02 - 0.02, by = 0.02)

points(time, state[,3], col = 'blue', type = 'l')
points(time, x.data[, 3], col = 'red', type = 'l')
