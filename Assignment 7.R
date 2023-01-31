#A
require(tidyverse)
set.seed(1)

df <- data.frame(replicate(50, rnorm(30, mean = rnorm(1, mean = 0),  sd = 3))) %>%
  rbind(data.frame(replicate(50, rnorm(30, mean = rnorm(1, mean = 1), sd = 3)))) %>%
  rbind(data.frame(replicate(50, rnorm(30, mean = rnorm(1, mean = 2), sd = 3)))) %>%
  as.tibble %>%
  mutate(id = row_number(),
         class = ifelse(id <= 30, 'A',
                        ifelse(id <= 60, 'B',
                               'C'))) %>%
  select(-id)


#B
remotes::install_github("vqv/ggbiplot")
Sys.setenv(R_REMOTES_NO_ERRORS_FROM_WARNINGS="true")
install_github("vqv/ggbiplot", force = TRUE)

require(ggbiplot);
require(ggthemes);
require(dplyr);

pca.df <- prcomp(df %>% select(-class), scale = TRUE)

ggbiplot(pca.df, groups = df$class, var.axes = FALSE,
         ellipse = TRUE) +
  geom_point(aes(col = df$class), size = 4) +
  theme_tufte(base_size = 16) +
  theme(legend.position = 'top') +
  guides(name = 'Groups') +
  scale_color_discrete(name = 'Class')


#C
scaling <- function(x) (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)
kmeans.clust <- df %>%
  select(-class) %>%
  kmeans(centers = 3)

ggbiplot(pca.df, groups = factor(kmeans.clust$cluster), var.axes = FALSE,
         ellipse = TRUE) +
  geom_point(aes(shape = df$class,
                 col = factor(kmeans.clust$cluster)), size = 4) +
  theme_tufte(base_size = 16) +
  theme(legend.position = 'top') +
  guides(name = 'Groups') +
  theme(legend.position = 'top') +
  scale_color_discrete(name = 'K-Means Groups') +
  scale_shape_discrete(name = 'Real Group')


#D
kmeans.clust <- df %>%
  select(-class) %>%
  kmeans(centers = 2)

ggbiplot(pca.df, groups = factor(kmeans.clust$cluster), var.axes = FALSE,
         ellipse = TRUE) +
  geom_point(aes(shape = df$class,
                 col = factor(kmeans.clust$cluster)), size = 4) +
  theme_tufte(base_size = 16) +
  theme(legend.position = 'top') +
  guides(name = 'Groups') +
  theme(legend.position = 'top') +
  scale_color_discrete(name = 'K-Means Groups') +
  scale_shape_discrete(name = 'Real Group')


#E
kmeans.clust <- df %>%
  select(-class) %>%
  kmeans(centers = 4)

ggbiplot(pca.df, groups = factor(kmeans.clust$cluster), var.axes = FALSE,
         ellipse = TRUE) +
  geom_point(aes(shape = df$class,
                 col = factor(kmeans.clust$cluster)), size = 4) +
  theme_tufte(base_size = 16) +
  theme(legend.position = 'top') +
  guides(name = 'Groups') +
  theme(legend.position = 'top') +
  scale_color_discrete(name = 'K-Means Groups') +
  scale_shape_discrete(name = 'Real Group')



#F
pca_2 <- pca.df$x %>%
  as.tibble %>%
  select(PC1, PC2)

pca_kmeans <- pca_2 %>%
  kmeans(centers = 3)

ggplot(pca_2, aes(PC1, PC2,
                  col = factor(pca_kmeans$cluster),
                  shape = df$class)) +
  geom_point(size = 4) +
  theme_tufte(base_size = 14) +
  scale_color_discrete(name = 'K-Means Group') +
  scale_shape_discrete(name = 'Real Class')


#G
scaling <- function(x) (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)

scaled_kmeans <- df %>%
  select(-class) %>%
  map_df(scaling) %>%
  kmeans(centers = 3)


ggbiplot(pca.df, groups = factor(scaled_kmeans$cluster), var.axes = FALSE,
         ellipse = TRUE) +
  geom_point(aes(shape = df$class,
                 col = factor(scaled_kmeans$cluster)), size = 4) +
  theme_tufte(base_size = 16) +
  theme(legend.position = 'top') +
  guides(name = 'Groups') +
  theme(legend.position = 'top') +
  scale_color_discrete(name = 'K-Means Groups') +
  scale_shape_discrete(name = 'Real Group')


#H
set.seed(2)

x <- matrix(rnorm(90 * 3), ncol = 3)

x[1:30, 1] <- x[1:30, 1] + 3
x[1:30, 2] <- x[1:30, 2] - 4
x[1:30, 3] <- x[1:30, 3] - 5

plot(x, pch = 16, bty = "n")

hc.complete <- hclust(dist(x), method = "complete")

par(mfrow = c(1, 3))
plot(hc.complete, main = "Complete Linkage",
     xlab = "", sub = "", cex = 0.3)
cutree(hc.complete, 3)

xsc <- scale(x)
par( mfrow = c(1,1) )
plot(hclust(dist(xsc), method = "complete"),
     main = "Hierarchical Clustering with Scaled Features ", cex = 0.3)


