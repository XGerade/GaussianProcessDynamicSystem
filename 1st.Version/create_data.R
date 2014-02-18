numForces <- 4
numTime <- 300
x.data <- matrix(0, numForces * numTime, 5)
x_2_out <- rep(0, numForces * numTime)
theta_2_out <-  rep(0, numForces * numTime)

l = 0.5
Mp = 0.1
Mc = 1
g = -9.81

tao = 0.02

k1 = -1
k2 = -1
k3 = 1
k4 = -0.1

for (Fm in 1 : numForces){
#Original State of the system
    theta_initial <- -0.15
    theta_1_initial <- -1
    x_initial <- 1
    x_1_initial <- 3
    theta_2 <- 0
    x_2 <- 0
    base <- (Fm - 1) * numTime

    for (i in 1 : numTime) {
        x.data[i + base, 1] <- theta_initial
        x.data[i + base, 2] <- theta_1_initial
        x.data[i + base, 3] <- x_initial
        x.data[i + base, 4] <- x_1_initial

        F <- Fm * sign(k1 * x_initial+ k2 * x_1_initial+ k3 * theta_initial+ k4 * theta_1_initial)
        x.data[i + base, 5] <- F

        
        theta_2 <- (g * sin(theta_initial) + cos(theta_initial) * ((-F - Mp * l * theta_1_initial ^ 2 * sin(theta_initial)) / (Mp + Mc))) / (l * (4 / 3 - Mp * cos(theta_initial) ^ 2 / (Mc + Mp)))
        x_2 <- (F + Mp * l * (theta_1_initial ^ 2 * sin(theta_initial) - theta_2 * cos(theta_initial))) / (Mp + Mc)
        
        theta_2_out[i + base] <- theta_2
        x_2_out[i + base] <- x_2

        x_initial <- x_initial + tao * x_1_initial
        x_1_initial <- x_1_initial + tao * x_2
        theta_initial <- theta_initial + tao * theta_1_initial
        theta_1_initial <- theta_1_initial + tao * theta_2
    }
}

#for (i in 1 : 1000000) {
#    i1 <- sample(1: numForces * numTime, 1)
#    i2 <- sample(1: numForces * numTime, 1)
#    temp <- x.data[i1,]
#    x.data[i1,] <- x.data[i2,]
#    x.data[i2,] <- temp
#    temp = x_2_out[i1]
#    x_2_out[i1] = x_2_out[i2]
#    x_2_out[i2] = temp
#    temp = theta_2_out[i1]
#    theta_2_out[i1] = theta_2_out[i2]
#    theta_2_out[i2] = temp
#}
#x.data <- x.data[1:2000,]
#x_2_out <- x_2_out[1:2000]
#theta_2_out <- theta_2_out[1:2000]
source("GPRegression.R")
K.xx <- calculateCovariance(x.data, x.data)
save(x.data, x_2_out, theta_2_out, K.xx, file = "Simulate_Results.RData")
