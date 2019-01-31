pca_model <- tbl(sc, "iris") %>%
+     select(-Species) %>%
+     ml_pca()

print(pca_model)
