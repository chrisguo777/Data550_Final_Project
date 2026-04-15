# F75 project: Kaplan-Meier module
# Owner: Helen Chen

cleaned_data <- readRDS("data/cleaned_data.rds")

library(survival)
library(survminer)
library(dplyr)

KM_arm <- survfit(Surv(days_stable, status) ~ arm, data = cleaned_data)
KM_sex <- survfit(Surv(days_stable, status) ~ sex, data = cleaned_data)
KM_kwash <- survfit(Surv(days_stable, status) ~ kwash, data = cleaned_data)
KM_hiv <- survfit(Surv(days_stable, status) ~ hiv_results, data = cleaned_data)
KM_bfeeding <- survfit(Surv(days_stable, status) ~ bfeeding, data = cleaned_data)
KM_site <- survfit(Surv(days_stable, status) ~ site, data = cleaned_data)

KM_plot_arm <- ggsurvplot(KM_arm, conf.int = T, pval = T)
KM_plot_sex <- ggsurvplot(KM_sex, conf.int = T, pval = T)
KM_plot_bfeeding <- ggsurvplot(KM_bfeeding, conf.int = T, pval = T)
KM_plot_kwash <- ggsurvplot(KM_kwash, conf.int = T, pval = T)
KM_plot_hiv <- ggsurvplot(KM_hiv, conf.int = T, pval = T)
KM_plot_site <- ggsurvplot(KM_site, conf.int = T, pval = T)

# Source: https://stats.oarc.ucla.edu/wp-content/uploads/2025/02/survival_r_full.html

ggsave(
  here::here("output/figure/KM_plot_arm.png"), 
  plot = KM_plot_arm$plot,
  device = "png"
)

ggsave(
  here::here("output/figure/KM_plot_sex.png"), 
  plot = KM_plot_sex$plot,
  device = "png"
)

ggsave(
  here::here("output/figure/KM_plot_bfeeding.png"), 
  plot = KM_plot_bfeeding$plot,
  device = "png"
)

ggsave(
  here::here("output/figure/KM_plot_kwash.png"),
  plot = KM_plot_kwash$plot,
  device = "png"
)

ggsave(
  here::here("output/figure/KM_plot_hiv.png"), 
  plot = KM_plot_hiv$plot,
  device = "png"
)

ggsave(
  here::here("output/figure/KM_plot_site.png"), 
  plot = KM_plot_site$plot,
  device = "png"
)
