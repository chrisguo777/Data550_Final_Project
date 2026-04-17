library(tidyverse)
library(here)
library(gtsummary)
library(broom)
library(gt)

data <- read_csv(here("data", "f75_interim.csv"), show_col_types = FALSE)

dir.create(here("output", "table"), recursive = TRUE, showWarnings = FALSE)

reg_data_logit <- data %>%
  select(discharged2, arm, agemons, sex, muac, weight, kwash, hiv_results) %>%
  mutate(
    discharged2 = factor(discharged2, levels = c("No", "Yes")),
    arm = relevel(factor(arm), ref = "Standard F75"),
    sex = relevel(factor(sex), ref = "Female"),
    kwash = relevel(factor(kwash), ref = "No"),
    hiv_results = relevel(factor(hiv_results), ref = "Negative")
  ) %>%
  drop_na() %>%
  droplevels()

logit_mod <- glm(
  discharged2 ~ arm + agemons + sex + muac + weight + kwash + hiv_results,
  data = reg_data_logit,
  family = binomial()
)

logit_tbl <- tbl_regression(logit_mod, exponentiate = TRUE) %>%
  bold_labels()

gt::gtsave(
  data = as_gt(logit_tbl),
  filename = here("output", "table", "logistic_regression_results.html")
)

write_csv(
  tidy(logit_mod, conf.int = TRUE, exponentiate = TRUE),
  here("output", "table", "logistic_regression_results.csv")
)

reg_data_linear <- data %>%
  select(days_stable, arm, agemons, sex, muac, weight, kwash, hiv_results) %>%
  filter(days_stable != 999) %>%
  mutate(
    arm = relevel(factor(arm), ref = "Standard F75"),
    sex = relevel(factor(sex), ref = "Female"),
    kwash = relevel(factor(kwash), ref = "No"),
    hiv_results = relevel(factor(hiv_results), ref = "Negative")
  ) %>%
  drop_na() %>%
  droplevels()

linear_mod <- lm(
  days_stable ~ arm + agemons + sex + muac + weight + kwash + hiv_results,
  data = reg_data_linear
)

linear_tbl <- tbl_regression(linear_mod) %>%
  bold_labels()

gt::gtsave(
  data = as_gt(linear_tbl),
  filename = here("output", "table", "linear_regression_results.html")
)

write_csv(
  tidy(linear_mod, conf.int = TRUE),
  here("output", "table", "linear_regression_results.csv")
)