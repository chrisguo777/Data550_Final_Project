# F75 project: supplementary EDA module
# Owner: Sihang Jiang
# Deliverables:
# 1. Correlation heatmap for continuous variables
# 2. Scatterplots relating continuous variables to days_stable
# 3. Optional customization for variable selection

suppressPackageStartupMessages({
  library(ggplot2)
})

dir.create("output/figure", showWarnings = FALSE, recursive = TRUE)

cleaned_data <- readRDS("data/cleaned_data.rds")

# TODO (Sihang Jiang):
# Create a correlation heatmap for:
# agemons, muac, weight, height, muac1, weight1, muac2, weight2, height2,
# and days_stable.
# Decide how to handle missing values and the special 999 code before computing
# correlations.
#
# TODO (Sihang Jiang):
# Create scatterplots between each continuous variable and days_stable.
# If the team wants customization, allow the user to choose variable pairs.

scatter_placeholder <- ggplot() +
  annotate("text", x = 1, y = 1, label = "TODO: heatmap / scatterplots go here", size = 6) +
  xlim(0, 2) +
  ylim(0, 2) +
  theme_void()

ggsave(
  filename = "output/figure/scatterplot_plan.png",
  plot = scatter_placeholder,
  width = 7,
  height = 5,
  dpi = 300
)

message("Saved supplementary EDA placeholder to output/figure/scatterplot_plan.png")
