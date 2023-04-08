
clear all
use GV482_CourseworkData_2022-23.dta, clear 

//summary statistics 
est clear
preserve
gen black_arrest_proportion = BlackTotalArrest/(BlackPct/100)
gen black_drug_proportion = BlackDrugArrest/(BlackPct/100)
collapse (mean) black_arrest_proportion black_drug_proportion, by(Year)
twoway line black_arrest_proportion Year

restore

//preserve
//collapse (mean) TotalArrest BlackTotalArrest DrugArrest BlackDrugArrest, by(Year)
qui estpost sum TotalArrest BlackTotalArrest DrugArrest BlackDrugArrest, d
esttab using "summary_stats.tex", tex cells("count(label(Obs.)) mean(fmt(3) label(Mean))  sd(fmt(3) label(St. Dev.)) min(fmt(3) label(Min.)) max(fmt(3) label(Max.))")  replace label nonum noobs

preserve
collapse (mean) TotalArrest BlackTotalArrest DrugArrest BlackDrugArrest, by(Year)
twoway line TotalArrest Year || line BlackTotalArrest Year
//twoway line BlackDrugArrest Year || line DrugArrest Year
restore
