# F75 project: summary tables module
# Owner: Sihang Jiang
# Deliverables:
# 1. Table 1. Baseline characteristics by treatment group
# 2. Table 2. Clinical outcomes by treatment group
# 3. Save report-ready tables to output/table/

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(forcats)
  library(gtsummary)
  library(tibble)
})

dir.create("output/table", showWarnings = FALSE, recursive = TRUE)

# Read raw data here so summary tables use the full sample
raw_data <- read_csv("data/f75_interim.csv", show_col_types = FALSE)

table_data <- raw_data %>%
  mutate(
    arm = factor(
      arm,
      levels = c("Standard F75", "Modified F75 (intervention)"),
      labels = c("Standard F75", "Modified F75")
    ),
    sex = factor(sex),
    site = factor(site),
    caregiver = factor(caregiver),
    bfeeding = factor(bfeeding),
    kwash = factor(kwash),
    shock = factor(shock),
    iconsciousness = factor(iconsciousness),
    sev_pneumonia = factor(sev_pneumonia),
    diarrhoea = factor(diarrhoea),
    malaria = factor(malaria),
    tb = factor(tb),
    hiv_results = factor(hiv_results),
    discharged2 = factor(discharged2),
    withdraw2 = fct_na_value_to_level(factor(withdraw2), level = "None"),
    
    # For Table 1
    oedema_any = ifelse(is.na(oedema), NA, "Yes"),
    oedema_any = factor(oedema_any, levels = c("No", "Yes")),
    
    # For Table 2
    days_stable_clean = ifelse(days_stable == 999, NA, days_stable),
    death = ifelse(days_stable == 999 | withdraw2 == "died", "Yes", "No"),
    death = factor(death, levels = c("No", "Yes")),
    successful_discharge = ifelse(discharged2 == "Yes", "Yes", "No"),
    successful_discharge = factor(successful_discharge, levels = c("No", "Yes")),
    reached_stabilization = ifelse(!is.na(days_stable_clean), "Yes", "No"),
    reached_stabilization = factor(reached_stabilization, levels = c("No", "Yes")),
    not_stabilized_before_death_withdrawal = ifelse(
      is.na(days_stable_clean) & (death == "Yes" | withdraw2 != "None"),
      "Yes", "No"
    ),
    not_stabilized_before_death_withdrawal =
      factor(not_stabilized_before_death_withdrawal, levels = c("No", "Yes"))
  )

# -------------------------
# Table 1: Baseline characteristics
# -------------------------
tbl1 <- table_data %>%
  select(
    arm,
    agemons, sex, site, caregiver, bfeeding,
    muac, weight, height, oedema_any,
    kwash, shock, iconsciousness, sev_pneumonia,
    diarrhoea, malaria, tb, hiv_results
  ) %>%
  tbl_summary(
    by = arm,
    statistic = list(
      all_continuous() ~ "{mean} ({sd})",
      agemons ~ "{median} ({p25}, {p75})"
    ),
    missing = "no",
    label = list(
      agemons ~ "Age (months)",
      sex ~ "Sex",
      site ~ "Site",
      caregiver ~ "Caregiver relationship",
      bfeeding ~ "Breastfeeding status",
      muac ~ "Baseline MUAC",
      weight ~ "Baseline weight",
      height ~ "Baseline height",
      oedema_any ~ "Baseline oedema",
      kwash ~ "Kwashiorkor",
      shock ~ "Shock",
      iconsciousness ~ "Impaired consciousness",
      sev_pneumonia ~ "Severe pneumonia",
      diarrhoea ~ "Diarrhoea",
      malaria ~ "Malaria",
      tb ~ "Tuberculosis",
      hiv_results ~ "HIV status"
    )
  ) %>%
  add_overall()

# -------------------------
# Table 2: Clinical outcomes
# -------------------------
tbl2_cat <- table_data %>%
  select(
    arm,
    death,
    successful_discharge,
    withdraw2,
    reached_stabilization,
    not_stabilized_before_death_withdrawal
  ) %>%
  tbl_summary(
    by = arm,
    statistic = all_categorical() ~ "{n} ({p}%)",
    missing = "no",
    label = list(
      death ~ "In-hospital death",
      successful_discharge ~ "Successful discharge",
      withdraw2 ~ "Withdrawal reason",
      reached_stabilization ~ "Reached stabilization",
      not_stabilized_before_death_withdrawal ~
        "Not stabilized before death/withdrawal"
    )
  ) %>%
  add_overall()

tbl2_days <- table_data %>%
  filter(!is.na(days_stable_clean)) %>%
  select(arm, days_stable_clean) %>%
  tbl_summary(
    by = arm,
    statistic = all_continuous() ~ "{median} ({p25}, {p75})",
    missing = "no",
    label = list(
      days_stable_clean ~ "Days to stabilization"
    )
  ) %>%
  add_overall()

# Save report-ready csv files
write_csv(as_tibble(tbl1), "output/table/table1_baseline.csv")
write_csv(as_tibble(tbl2_cat), "output/table/table2_outcomes_cat.csv")
write_csv(as_tibble(tbl2_days), "output/table/table2_outcomes_days.csv")
