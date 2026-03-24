# F75 project: Kaplan-Meier module
# Owner: Helen Chen
# Deliverables:
# 1. Create a survival object using days to stabilization
# 2. Recode the stabilization event indicator according to the team definition
# 3. Allow stratified Kaplan-Meier curves by selected clinical variables
# 4. Save the final curve(s) to output/figure/


cleaned_data <- readRDS("data/cleaned_data.rds")

# TODO (Helen Chen):
# Define the event indicator carefully.
# The current team plan says "stabilization = 1 if there is a death (999)" and
# "0 otherwise", but this should be rechecked because that coding sounds more like
# a censoring/event-status rule than literal stabilization.
# Confirm the exact survival outcome before fitting survfit().
#
# TODO (Helen Chen):
# Implement stratified KM curves for:
# arm, sex, kwash, hiv_results, and milkfeed.
# Save the final KM plot as output/figure/km_curve.png.

