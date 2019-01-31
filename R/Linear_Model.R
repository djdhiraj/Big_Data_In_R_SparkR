lm_model <- iris_tbl %>%
+     select(Petal_Width, Petal_Length) %>%
+     ml_linear_regression(Petal_Length ~ Petal_Width)

lm_model

iris_tbl %>%
+     select(Petal_Width, Petal_Length) %>%
+     collect %>%
+     ggplot(aes(Petal_Length, Petal_Width)) +
+     geom_point(aes(Petal_Width, Petal_Length), size = 2, alpha = 0.5) +
+     geom_abline(aes(slope = coef(lm_model)[["Petal_Width"]],
+                     intercept = coef(lm_model)[["(Intercept)"]]),
+                 color = "red") +
+     labs(
+         x = "Petal Width",
+         y = "Petal Length",
+         title = "Linear Regression: Petal Length ~ Petal Width",
+         subtitle = "Use Spark.ML linear regression to predict petal length as a function of petal width."
+     )
