# F75 project: boxplot module
# Owner: Yixin Hu
# Deliverables:
# 1. Boxplots for MUAC at baseline, stabilization, and discharge
# 2. Boxplots for weight at baseline, stabilization, and discharge
# 3. Boxplots for height at baseline and discharge
# 4. Save final figure files to output/figure/



# TODO (Yixin Hu):
# Reshape the data into long format for time-based boxplots.
# Use muac, muac1, muac2 for MUAC; weight, weight1, weight2 for weight;
# and height, height2 for height.
# Set x = time point and y = value, then compare medians and IQRs over time.
# If desired, color by time point for readability and export separate figure files.

# F75 project: boxplot module
# Owner: Yixin Hu
# Deliverables:
# 1. Boxplots for MUAC at baseline, stabilization, and discharge
# 2. Boxplots for weight at baseline, stabilization, and discharge
# 3. Boxplots for height at baseline and discharge
# 4. Save final figure files to output/figure/

# F75 project: boxplot module
# Owner: Yixin Hu
# Deliverables:
# 1. Boxplots for MUAC at baseline, stabilization, and discharge
# 2. Boxplots for weight at baseline, stabilization, and discharge
# 3. Boxplots for height at baseline and discharge
# 4. Save final figure files to output/figure/

library(dplyr)
library(tidyr)
library(ggplot2)

#-----------------------------
# Read cleaned data
#-----------------------------
dat <- readRDS("data/cleaned_data.rds")

#-----------------------------
# Create output folder if needed
#-----------------------------
dir.create("output/figure", recursive = TRUE, showWarnings = FALSE)

#-----------------------------
# MUAC boxplot
# Variables:
# muac  = baseline
# muac1 = stabilization
# muac2 = discharge
#-----------------------------
muac_long <- dat %>%
  select(muac, muac1, muac2) %>%
  pivot_longer(
    cols = c(muac, muac1, muac2),
    names_to = "time",
    values_to = "value"
  ) %>%
  mutate(
    time = recode(
      time,
      "muac"  = "Baseline",
      "muac1" = "Stabilization",
      "muac2" = "Discharge"
    ),
    time = factor(time, levels = c("Baseline", "Stabilization", "Discharge"))
  ) %>%
  filter(!is.na(value))

p_muac <- ggplot(muac_long, aes(x = time, y = value, fill = time)) +
  geom_boxplot(width = 0.65, outlier.alpha = 0.5) +
  labs(
    title = "MUAC at Baseline, Stabilization, and Discharge",
    x = "Time Point",
    y = "MUAC"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    legend.position = "none",
    plot.title = element_text(hjust = 0.5)
  )

ggsave(
  filename = "output/figure/muac_boxplot.png",
  plot = p_muac,
  width = 8,
  height = 6,
  dpi = 300
)

#-----------------------------
# Weight boxplot
# Variables:
# weight  = baseline
# weight1 = stabilization
# weight2 = discharge
#-----------------------------
weight_long <- dat %>%
  select(weight, weight1, weight2) %>%
  pivot_longer(
    cols = c(weight, weight1, weight2),
    names_to = "time",
    values_to = "value"
  ) %>%
  mutate(
    time = recode(
      time,
      "weight"  = "Baseline",
      "weight1" = "Stabilization",
      "weight2" = "Discharge"
    ),
    time = factor(time, levels = c("Baseline", "Stabilization", "Discharge"))
  ) %>%
  filter(!is.na(value))

p_weight <- ggplot(weight_long, aes(x = time, y = value, fill = time)) +
  geom_boxplot(width = 0.65, outlier.alpha = 0.5) +
  labs(
    title = "Weight at Baseline, Stabilization, and Discharge",
    x = "Time Point",
    y = "Weight"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    legend.position = "none",
    plot.title = element_text(hjust = 0.5)
  )

ggsave(
  filename = "output/figure/weight_boxplot.png",
  plot = p_weight,
  width = 8,
  height = 6,
  dpi = 300
)

#-----------------------------
# Height boxplot
# Variables:
# height  = baseline
# height2 = discharge
#-----------------------------
height_long <- dat %>%
  select(height, height2) %>%
  pivot_longer(
    cols = c(height, height2),
    names_to = "time",
    values_to = "value"
  ) %>%
  mutate(
    time = recode(
      time,
      "height"  = "Baseline",
      "height2" = "Discharge"
    ),
    time = factor(time, levels = c("Baseline", "Discharge"))
  ) %>%
  filter(!is.na(value))

p_height <- ggplot(height_long, aes(x = time, y = value, fill = time)) +
  geom_boxplot(width = 0.65, outlier.alpha = 0.5) +
  labs(
    title = "Height at Baseline and Discharge",
    x = "Time Point",
    y = "Height"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    legend.position = "none",
    plot.title = element_text(hjust = 0.5)
  )

ggsave(
  filename = "output/figure/height_boxplot.png",
  plot = p_height,
  width = 8,
  height = 6,
  dpi = 300
)

#-----------------------------
# Optional: print plots in RStudio viewer
#-----------------------------
print(p_muac)
print(p_weight)
print(p_height)

