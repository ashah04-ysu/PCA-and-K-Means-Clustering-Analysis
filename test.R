set.seed(2)

x <- matrix(rnorm(30 * 3), ncol = 3)

x[1:10, 1] <- x[1:10, 1] + 3
x[1:10, 2] <- x[1:10, 2] - 4
x[1:10, 3] <- x[1:10, 3] - 5

plot(x, pch = 16, bty = "n")

hc.complete <- hclust(dist(x), method = "complete")

par(mfrow = c(1, 3))
plot(hc.complete, main = "Complete Linkage",
     xlab = "", sub = "", cex = 0.9)
cutree(hc.complete, 2)

xsc <- scale(x)
par( mfrow = c(1,1) )
plot(hclust(dist(xsc), method = "complete"),
     main = "Hierarchical Clustering with Scaled Features ")

