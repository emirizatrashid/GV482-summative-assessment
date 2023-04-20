
clear all
use GV482_CourseworkData_2022-23.dta, clear 

//summary statistics 

qui estpost sum TotalArrest BlackTotalArrest DrugArrest BlackDrugArrest, d
esttab using "summary_stats.tex", tex cells("count(label(Obs.)) mean(fmt(3) label(Mean))  sd(fmt(3) label(St. Dev.)) min(fmt(3) label(Min.)) max(fmt(3) label(Max.))")  replace label nonum noobs

est clear 

global vars Agencies BlackPct HispPct BlackPct_2000 HispPct_2000 

preserve
collapse (mean) TotalArrest BlackTotalArrest DrugArrest BlackDrugArrest, by(Year)

//to produce the graph
twoway line TotalArrest Year || line BlackTotalArrest Year 
twoway line BlackDrugArrest Year || line DrugArrest Year 
restore

//OLS regression

//start with the voting after prison
est clear
qui eststo: reg TotalArrest VoteAfterPrison
qui eststo: reg TotalArrest VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg TotalArrest VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg TotalArrest VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies
esttab using "vote_after_prison_arrest.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterPrison) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Total Arrests Per Capita", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})



est clear

qui eststo: reg DrugArrest VoteAfterPrison
qui eststo: reg DrugArrest VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg DrugArrest VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg DrugArrest VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies

esttab using "vote_after_prison_drugarrest.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterPrison) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Drug Arrest Per Capita", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})


est clear 

qui eststo: reg BlackTotalArrest VoteAfterPrison
qui eststo: reg BlackTotalArrest VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg BlackTotalArrest VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg BlackTotalArrest VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies

esttab using "vote_after_prison_BlackTotalArrest.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterPrison) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Black Arrest Per Capita", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})

est clear

qui eststo: reg BlackDrugArrest VoteAfterPrison
qui eststo: reg BlackDrugArrest VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg BlackDrugArrest VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg BlackDrugArrest VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies

esttab using "vote_after_prison_blackdrugarrest_percapita.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterPrison) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Black Drug Arrest Per Capita", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})



//Now for vote after parole

est clear
qui eststo: reg TotalArrest VoteAfterParole
qui eststo: reg TotalArrest VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg TotalArrest VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg TotalArrest VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies

esttab using "voter_after_parole_arrest.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterParole) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Total Arrests Per Capita", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})


est clear

qui eststo: reg DrugArrest VoteAfterParole
qui eststo: reg DrugArrest VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg DrugArrest VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg DrugArrest VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies

esttab using "voter_after_parole_drugarrest.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterParole) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Drug Arrest Per Capita", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})



est clear

qui eststo: reg BlackTotalArrest VoteAfterParole
qui eststo: reg BlackTotalArrest VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg BlackTotalArrest VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg BlackTotalArrest VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies

esttab using "vote_after_parole_BlackTotalArrest.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterParole) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Black Arrest Per Capita", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})

est clear

qui eststo: reg BlackDrugArrest VoteAfterParole
qui eststo: reg BlackDrugArrest VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg BlackDrugArrest VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg BlackDrugArrest VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies

esttab using "vote_after_parole_blackdrugarrest_percapita.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterParole) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Black Drug Arrest Per Capita", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})



//Now vote after probation

est clear
qui eststo: reg TotalArrest VoteAfterProbation
qui eststo: reg TotalArrest VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg TotalArrest VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg TotalArrest VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies
esttab using "voter_after_probation_arrest.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterProbation) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Total Arrests Per Capita", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})

est clear 



qui eststo: reg DrugArrest VoteAfterProbation
qui eststo: reg DrugArrest VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg DrugArrest VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg DrugArrest VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies

esttab using "voter_after_probation_drugarrest.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterProbation) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Drug Arrest Per Capita", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})

est clear


qui eststo: reg BlackTotalArrest VoteAfterProbation
qui eststo: reg BlackTotalArrest VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg BlackTotalArrest VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg BlackTotalArrest VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies

esttab using "vote_after_probation_BlackTotalArrest.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterProbation) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Black Arrest Per Capita", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})

est clear

qui eststo: reg BlackDrugArrest VoteAfterProbation
qui eststo: reg BlackDrugArrest VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg BlackDrugArrest VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg BlackDrugArrest VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies
esttab using "vote_after_probation_blackdrugarrest_percapita.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterProbation) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Black Drug Arrest Per Capita", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})

est clear 

//Now for the more robust research design 



