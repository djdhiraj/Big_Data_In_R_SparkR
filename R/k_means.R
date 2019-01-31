library(sparklyr)
devtools::install_github("rstudio/sparklyr")
sc <- spark_connect(master = "local")
library(dplyr)
iris_tbl <- copy_to(sc, iris)
flights_tbl <- copy_to(sc, nycflights13::flights, "flights")
batting_tbl <- copy_to(sc, Lahman::Batting, "batting")
src_tbls(sc)

View(iris_tbl)

kmeans_model <- iris_tbl %>% 
+     ml_kmeans(formula= ~ Petal_Width + Petal_Length, centers = 3)

kmeans_model

predicted <- sdf_predict(kmeans_model, iris_tbl) %>%
+     collect

table(predicted$Species, predicted$prediction)

library(ggplot2)

sdf_predict(kmeans_model) %>%
+     collect() %>%
+     ggplot(aes(Petal_Length, Petal_Width)) +
+     geom_point(aes(Petal_Width, Petal_Length, col = factor(prediction + 1)),
+                size = 2, alpha = 0.5) + 
+     geom_point(data = kmeans_model$centers, aes(Petal_Width, Petal_Length),
+                col = scales::muted(c("red", "green", "blue")),
+                pch = 'x', size = 12) +
+     scale_color_discrete(name = "Predicted Cluster",
+                          labels = paste("Cluster", 1:3)) +
+     labs(
+         x = "Petal Length",
+         y = "Petal Width",
+         title = "K-Means Clustering",
+         subtitle = "Use Spark.ML to predict cluster membership with the iris dataset."
+     )
