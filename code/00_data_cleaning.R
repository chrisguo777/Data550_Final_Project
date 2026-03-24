# F75 project: data cleaning and analysis dataset preparation
# Project leader note:
# This script should stay focused on data import, recoding, and cleaning only.
# Do not place figures, tables, or regression models here.
library(dplyr)
library(readr)

raw_data <- read_csv("data/f75_interim.csv", show_col_types = FALSE)

cleaned_data <- raw_data %>%
  mutate(
    arm = factor(arm),
    sex = factor(sex),
    site = factor(site)
  )

# TODO (Project leader):
# Confirm the final cleaned-data variable dictionary and missing-value rules.
# Decide whether special codes such as 999 in days_stable should be recoded here
# or preserved and handled downstream in the survival and outcomes modules.
#
# TODO (All teammates):
# Add any shared recoding steps here only if they are needed by multiple modules.
# Module-specific transformations should stay inside each analysis script.

saveRDS(cleaned_data, "data/cleaned_data.rds")