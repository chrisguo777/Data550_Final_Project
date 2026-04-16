# F75 project: supplementary EDA module
# Owner: Sihang Jiang
# Deliverables:
# 1. Correlation heatmap for continuous variables
# 2. Scatterplots relating continuous variables to days_stable

suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(ggplot2)
  library(tibble)
})

dir.create("output/figure", showWarnings = FALSE, recursive = TRUE)

cleaned_data <- readRDS("data/cleaned_data.rds")

cont_vars <- c(
  "agemons", "muac", "weight", "height",
  "muac1", "weight1", "muac2", "weight2", "height2",
  "days_stable"
)

corr_df <- cleaned_data %>%
  select(all_of(cont_vars)) %>%
  cor(use = "pairwise.complete.obs") %>%
  as.data.frame() %>%
  rownames_to_column("var1") %>%
  pivot_longer(-var1, names_to = "var2", values_to = "correlation")

p_heat <- ggplot(corr_df, aes(x = var1, y = var2, fill = correlation)) +
  geom_tile() +
  geom_text(aes(label = round(correlation, 2)), size = 3) +
  scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0) +
  labs(
    title = "Correlation heatmap of continuous variables",
    x = NULL,
    y = NULL
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave(
  filename = "output/figure/heatmap_continuous.png",
  plot = p_heat,
  width = 10,
  height = 8,
  dpi = 300
)

for (v in c("agemons", "muac", "weight", "height")) {
  p <- ggplot(cleaned_data, aes(x = .data[[v]], y = days_stable)) +
    geom_point(alpha = 0.7) +
    geom_smooth(method = "lm", se = FALSE) +
    labs(
      title = paste(v, "vs days to stabilization"),
      x = v,
      y = "Days to stabilization"
    ) +
    theme_minimal()
  
  ggsave(
    filename = paste0("output/figure/scatter_", v, "_days_stable.png"),
    plot = p,
    width = 7,
    height = 5,
    dpi = 300
  )
}
