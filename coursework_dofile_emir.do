
clear all
use GV482_CourseworkData_2022-23.dta, clear 

//summary statistics 

gen BlackArrestPerBlack = BlackTotalArrest/(BlackPct/100)
gen BlackDrugArrestPerBlack = BlackDrugArrest/(BlackPct/100)
label var BlackArrestPerBlack "Black Arrest over Black Population"
label var BlackDrugArrestPerBlack "Black Drug Arrest over Black Population"



//preserve
//collapse (mean) TotalArrest BlackTotalArrest DrugArrest BlackDrugArrest, by(Year)
qui estpost sum TotalArrest BlackTotalArrest DrugArrest BlackDrugArrest BlackArrestPerBlack BlackDrugArrestPerBlack, d
esttab using "summary_stats.tex", tex cells("count(label(Obs.)) mean(fmt(3) label(Mean))  sd(fmt(3) label(St. Dev.)) min(fmt(3) label(Min.)) max(fmt(3) label(Max.))")  replace label nonum noobs

preserve
collapse (mean) TotalArrest BlackTotalArrest DrugArrest BlackDrugArrest BlackArrestPerBlack BlackDrugArrestPerBlack, by(Year)

//to produce the graph

//twoway line TotalArrest Year || line BlackTotalArrest Year || line BlackArrestPerBlack Year
//twoway line BlackDrugArrest Year || line DrugArrest Year || line BlackDrugArrestPerBlack Year
restore

//OLS regression

//start with the voting after prison
est clear
qui eststo: reg TotalArrest VoteAfterPrison
qui eststo: reg TotalArrest VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg TotalArrest VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg TotalArrest VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div
esttab using "vote_after_prison_arrest.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterPrison) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Total Arrests Per Capita", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})

est clear 

qui eststo: reg BlackArrestPerBlack VoteAfterPrison
qui eststo: reg BlackArrestPerBlack VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg BlackArrestPerBlack VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg BlackArrestPerBlack VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div

esttab using "vote_after_prison_blackarrest.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterPrison) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Black Arrest Per Black Population", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})

est clear

qui eststo: reg DrugArrest VoteAfterPrison
qui eststo: reg DrugArrest VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg DrugArrest VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg DrugArrest VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div

esttab using "vote_after_prison_drugarrest.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterPrison) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Drug Arrest Per Capita", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})

est clear

qui eststo: reg BlackDrugArrestPerBlack VoteAfterPrison
qui eststo: reg BlackDrugArrestPerBlack VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg BlackDrugArrestPerBlack VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg BlackDrugArrestPerBlack VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div

esttab using "vote_after_prison_blackdrugarrest.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterPrison) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Black Drug Arrest Per Black", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})

//Now for vote after parole

est clear
qui eststo: reg TotalArrest VoteAfterParole
qui eststo: reg TotalArrest VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg TotalArrest VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg TotalArrest VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div
esttab using "voter_after_parole_arrest.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterParole) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Total Arrests Per Capita", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})

est clear 

qui eststo: reg BlackArrestPerBlack VoteAfterParole
qui eststo: reg BlackArrestPerBlack VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg BlackArrestPerBlack VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg BlackArrestPerBlack VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div

esttab using "voter_after_parole_blackarrest.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterParole) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Black Arrest Per Black Population", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})

est clear

qui eststo: reg DrugArrest VoteAfterParole
qui eststo: reg DrugArrest VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg DrugArrest VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg DrugArrest VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div

esttab using "voter_after_parole_drugarrest.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterParole) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Drug Arrest Per Capita", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})

est clear

qui eststo: reg BlackDrugArrestPerBlack VoteAfterParole
qui eststo: reg BlackDrugArrestPerBlack VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg BlackDrugArrestPerBlack VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg BlackDrugArrestPerBlack VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div

esttab using "voter_after_parole_blackdrugarrest.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterParole) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Black Drug Arrest Per Black", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})

//Now vote after probation

est clear
qui eststo: reg TotalArrest VoteAfterProbation
qui eststo: reg TotalArrest VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg TotalArrest VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg TotalArrest VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div
esttab using "voter_after_probation_arrest.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterProbation) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Total Arrests Per Capita", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})

est clear 

qui eststo: reg BlackArrestPerBlack VoteAfterProbation
qui eststo: reg BlackArrestPerBlack VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg BlackArrestPerBlack VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg BlackArrestPerBlack VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div

esttab using "voter_after_probation_blackarrest.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterProbation) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Black Arrest Per Black Population", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})

est clear

qui eststo: reg DrugArrest VoteAfterProbation
qui eststo: reg DrugArrest VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg DrugArrest VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg DrugArrest VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div

esttab using "voter_after_probation_drugarrest.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterProbation) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Drug Arrest Per Capita", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})

est clear

qui eststo: reg BlackDrugArrestPerBlack VoteAfterProbation
qui eststo: reg BlackDrugArrestPerBlack VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg BlackDrugArrestPerBlack VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg BlackDrugArrestPerBlack VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div

esttab using "voter_after_probation_blackdrugarrest.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterProbation) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Black Drug Arrest Per Black", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})


