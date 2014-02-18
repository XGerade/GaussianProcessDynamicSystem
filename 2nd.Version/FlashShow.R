library(animation)
load("Sim_Results.RData")
source("CommenVar.R")

saveGIF({
    for (i in 1 : dataSize) {
        theta <- x.data[i, 1]
        x <- x.data[i, 3]
        
    }
})


plot(-5, xlim = c(1,150), ylim = c(0, .3), axes = F, xlab = "", ylab = "")
abline(v=3, lwd=5, col = rgb(0, 0, 255, 255, maxColorValue=255))
