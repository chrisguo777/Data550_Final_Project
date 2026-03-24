# F75 project: regression module
# Owners: Yuchen Li and Helen Chen
# Deliverables:
# 1. Logistic regression for discharged2
# 2. Linear regression for days_stable
# 3. Feature-selection workflow choice: LASSO, AIC, or BIC
# 4. Save model summary outputs for the report


# TODO (Yuchen Li and Helen Chen):
# Logistic regression task:
# Outcome = discharged2.
# Decide predictor set, train/test split, preprocessing, and whether to use
# LASSO or stepwise AIC/BIC for feature selection.
# Report odds ratios, 95% confidence intervals, and p-values.
#
# TODO (Yuchen Li and Helen Chen):
# Linear regression task:
# Outcome = days_stable.
# Decide whether records with days_stable == 999 are excluded, recoded, or
# handled in a separate sensitivity analysis before fitting the model.
# Report coefficients, 95% confidence intervals, and p-values.
#
# TODO (Project leader):
# Confirm the team's customization choices:
# feature-selection method and number of CV folds for LASSO.