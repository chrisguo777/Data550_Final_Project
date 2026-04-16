all: report/final_report.html

data/cleaned_data.rds: code/00_data_cleaning.R data/f75_interim.csv
	Rscript code/00_data_cleaning.R
	
output/figure/muac_boxplot.png \
output/figure/weight_boxplot.png \
output/figure/height_boxplot.png: \
code/01_boxplots.R data/cleaned_data.rds
	Rscript code/01_boxplots.R
	
output/figure/km_curve.png: code/02_kaplan_meier_curve.R data/cleaned_data.rds
	Rscript code/02_kaplan_meier_curve.R

output/table/required_table.csv: code/03_summary_tables.R data/cleaned_data.rds
	Rscript code/03_summary_tables.R
	
output/table/regression_results.csv: code/04_regression.R data/cleaned_data.rds
	Rscript code/04_regression.R

output/figure/KM_plot_sex.png \
output/figure/KM_plot_site.png \
output/figure/KM_plot_bfeeding.png \
output/figure/KM_plot_kwash.png \
output/figure/KM_plot_hiv.png \
output/figure/KM_plot_arm.png: code/02_kaplan_meier_curve.R data/cleaned_data.rds
	Rscript code/02_kaplan_meier_curve.R

report/final_report.html: report/final_report.Rmd \
	output/figure/muac_boxplot.png \
	output/figure/weight_boxplot.png \
	output/figure/height_boxplot.png \
	output/figure/KM_plot_sex.png \
	output/figure/KM_plot_site.png \
	output/figure/KM_plot_bfeeding.png \
	output/figure/KM_plot_kwash.png \
	output/figure/KM_plot_hiv.png \
	output/figure/KM_plot_arm.png \
	output/table/required_table.csv \
	output/table/regression_results.csv
	Rscript -e "rmarkdown::render('report/final_report.Rmd', output_file = 'final_report.html', output_dir = 'report')"


clean:
	rm -f report/final_report.html
	rm -f data/cleaned_data.rds
	rm -f output/figure/*
	rm -f output/table/*
	