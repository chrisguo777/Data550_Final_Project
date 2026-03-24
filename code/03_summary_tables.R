# F75 project: summary tables module
# Owner: Sihang Jiang
# Deliverables:
# 1. Table 1. Baseline characteristics by treatment group
# 2. Table 2. Clinical outcomes by treatment group
# 3. Save report-ready tables to output/table/

cleaned_data <- readRDS("data/cleaned_data.rds")


# TODO (Sihang Jiang):
# Build Table 1 using baseline variables only:
# agemons, sex, site, caregiver, bfeeding, muac, weight, height, oedema,
# kwash, shock, iconsciousness, sev_pneumonia, diarrhoea, malaria, tb,
# hiv_results, and participant counts.
# Use tbl_summary() or another report-ready workflow.
#
# TODO (Sihang Jiang):
# Build Table 2 using outcome variables:
# discharged2, withdraw2, days_stable, and a derived stabilization indicator.
# Treat days_stable == 999 as a non-time code rather than a true number.
#
# TODO (Project leader):
# Decide whether the required table for the assignment should be Table 1 only
# or a separate exported "summary table" object for the final report.
