# PCA and K-Means Clustering Analysis
## Introduction
The purpose of this analysis is to perform principal component analysis (PCA) and K-Means clustering on a synthetic data set of 180 observations and 50 variables. The data set contains three classes labeled as 'A', 'B', and 'C'. The goal is to visually inspect the clustering results from PCA and K-Means.

## Data Preparation
The data set was generated using the rnorm() function in R to create random normal distributions. The following code was used to generate the data set:

1. set.seed(1)
2. df <- data.frame(replicate(50, rnorm(30, mean = rnorm(1, mean = 0),  sd = 3))) %>%
3.   rbind(data.frame(replicate(50, rnorm(30, mean = rnorm(1, mean = 1), sd = 3)))) %>%
4.   rbind(data.frame(replicate(50, rnorm(30, mean = rnorm(1, mean = 2), sd = 3)))) %>%
5.   as.tibble %>%
6.   mutate(id = row_number(),
7.         class = ifelse(id <= 30, 'A',
8.                         ifelse(id <= 60, 'B',
9.                               'C'))) %>%
10.   select(-id)

## PCA Plotting
The following libraries were used for the PCA and K-Means clustering analysis:

tidyverse,
ggbiplot,
ggthemes,
dplyr

PCA was performed on the data set using the prcomp() function from the stats library in R. The PCA plot was created using the ggbiplot() function from the ggbiplot library. The plot was further customized using the geom_point() and theme() functions.

1. pca.df <- prcomp(df %>% select(-class), scale = TRUE)

2. ggbiplot(pca.df, groups = df$class, var.axes = FALSE,
         ellipse = TRUE) +
3.   geom_point(aes(col = df$class), size = 4) +
4.   theme_tufte(base_size = 16) +
5.   theme(legend.position = 'top') +
6.   guides(name = 'Groups') +
7.   scale_color_discrete(name = 'Class')


## K-Means Clustering Plotting
K-Means clustering was performed on the data set using the kmeans() function from the stats library in R. The K-Means clustering plot was created by plotting the first two principal components obtained from PCA and coloring the points based on the K-Means cluster assignments. The plot was further customized using the geom_point() and theme() functions.

1. kmeans.clust <- df %>%
2.   select(-class) %>%
3.   kmeans(centers = 3)

4. ggbiplot(pca.df, groups = factor(kmeans.clust$cluster), var.axes = FALSE,
         ellipse = TRUE) +
5.   geom_point(aes(shape = df$class,
                 col
