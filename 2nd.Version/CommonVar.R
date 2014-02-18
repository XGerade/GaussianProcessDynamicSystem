#Model Data Size
ForcesStart <- 1
ForcesEnd <- 6
numForces <- ForcesEnd - ForcesStart + 1
numTime <- 200
dataSize <- numForces * numTime

#Physical Parameters
l = 0.5
Mp = 0.1
Mc = 1
g = -9.81


#parameters for control system
k1 <- -1
k2 <- -1
k3 <- 1
k4 <- -0.1

#Simulation Parameter
tao <- 0.02
timeLength <- 300
sigma.squared = 0.001
