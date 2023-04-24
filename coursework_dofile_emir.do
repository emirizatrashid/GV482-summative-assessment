
clear all
use GV482_CourseworkData_2022-23.dta, clear 

//creating the new variable which is the ratio of black to total arrests

gen BlackTotalRatio = BlackTotalArrest/TotalArrest
gen BlackDrugRatio = BlackDrugArrest/DrugArrest
label variable BlackTotalRatio "Black Arrests to Total Arrests Ratio"
label variable BlackDrugRatio "Black Drug Arrests to Total Drug Arrests Ratio"

//summary statistics 

qui estpost sum TotalArrest BlackTotalArrest DrugArrest BlackDrugArrest BlackTotalRatio BlackDrugRatio, d
esttab using "summary_stats.tex", tex cells("count(label(Obs.)) mean(fmt(3) label(Mean))  sd(fmt(3) label(St. Dev.)) min(fmt(3) label(Min.)) max(fmt(3) label(Max.))")  replace label nonum noobs

est clear 

//preserve
//collapse (mean) TotalArrest BlackTotalRatio DrugArrest BlackDrugRatio, by(Year)

//to produce the graph
//twoway line TotalArrest Year || line DrugArrest Year  
//twoway line BlackTotalRatio Year || line BlackDrugRatio Year 
//restore

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

qui eststo: reg BlackTotalRatio VoteAfterPrison
qui eststo: reg BlackTotalRatio VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg BlackTotalRatio VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg BlackTotalRatio VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies

esttab using "vote_after_prison_BlackTotalRatio.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterPrison) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Black to Total Arrest Ratio", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})

est clear

qui eststo: reg BlackDrugRatio VoteAfterPrison
qui eststo: reg BlackDrugRatio VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg BlackDrugRatio VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg BlackDrugRatio VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies

esttab using "vote_after_prison_BlackDrugRatio.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterPrison) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Black to Total Drug Arrest Ratio", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})

est clear




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
//qui eststo: reg DrugArrest VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies

esttab using "did_control_table.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterParole) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Drug Arrest Per Capita", pattern(1 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})

est clear

qui eststo: reg BlackTotalRatio VoteAfterParole
qui eststo: reg BlackTotalRatio VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg BlackTotalRatio VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg BlackTotalRatio VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies

esttab using "vote_after_parole_BlackTotalRatio.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterParole) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Black to Total Arrest Ratio", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})

est clear

qui eststo: reg BlackDrugRatio VoteAfterParole
qui eststo: reg BlackDrugRatio VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg BlackDrugRatio VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg BlackDrugRatio VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies

esttab using "vote_after_parole_BlackDrugRatio.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterParole) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Black to Total Drug Arrest Ratio", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})

est clear




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


est clear 
qui eststo: reg BlackTotalRatio VoteAfterProbation
qui eststo: reg BlackTotalRatio VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg BlackTotalRatio VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg BlackTotalRatio VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies

esttab using "vote_after_probation_BlackTotalRatio.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterProbation) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Black to Total Arrest Ratio", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})

est clear

qui eststo: reg BlackDrugRatio VoteAfterProbation
qui eststo: reg BlackDrugRatio VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg BlackDrugRatio VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg BlackDrugRatio VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies

esttab using "vote_after_probation_BlackDrugRatio.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterProbation) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Black to Total Drug Arrest Ratio", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})

est clear




//Now for the more robust research design -- Event Study

egen id = group(State)

//generating year implemented 

bysort State (Year): gen VoteAfterPrisonImplemented = Year if VoteAfterPrison
bysort State (VoteAfterPrisonImplemented): replace VoteAfterPrisonImplemented = VoteAfterPrisonImplemented[1]
bysort State (Year): gen VoteAfterParoleImplemented = Year if VoteAfterParole
bysort State (VoteAfterParoleImplemented): replace VoteAfterParoleImplemented = VoteAfterParoleImplemented[1]
bysort State (Year): gen VoteAfterProbationImplemented = Year if VoteAfterProbation
bysort State (VoteAfterProbationImplemented): replace VoteAfterProbationImplemented = VoteAfterProbationImplemented[1]

//ssc install csdid
//ssc install drdid
//ssc install reghdfe
//net install ddtiming, from(https://tgoldring.com/code/)

//Effect of Vote After Prison

replace VoteAfterPrisonImplemented = 3000 if VoteAfterPrisonImplemented == .
csdid TotalArrest, ivar(id) time(Year) gvar(VoteAfterPrisonImplemented) notyet
qui: estat event
//csdid_plot
estat simple
est clear
//Effect on Total Drug Arrest Per Capita Elapsed Time Since Vote After Prison is Implemented
csdid DrugArrest, ivar(id) time(Year) gvar(VoteAfterPrisonImplemented) notyet
qui: estat event
//csdid_plot
estat simple
est clear

csdid BlackTotalRatio , ivar(id) time(Year) gvar(VoteAfterPrisonImplemented) notyet
qui: estat event
//csdid_plot
estat simple
est clear

csdid BlackDrugRatio, ivar(id) time(Year) gvar(VoteAfterPrisonImplemented) notyet
qui: estat event
//csdid_plot
estat simple
est clear


//Effect of Vote After Parole 

//Effect on Total Drug Arrest Per Capita Elapsed Time Since Vote After Prison is Implemented

replace VoteAfterParoleImplemented = 3000 if VoteAfterParoleImplemented == .
csdid TotalArrest, ivar(id) time(Year) gvar(VoteAfterParoleImplemented) notyet
qui: estat event
//csdid_plot
estat simple
est clear


csdid DrugArrest, ivar(id) time(Year) gvar(VoteAfterParoleImplemented) notyet
qui: estat event
//csdid_plot
estat simple
est clear

csdid BlackTotalRatio, ivar(id) time(Year) gvar(VoteAfterParoleImplemented) notyet
qui: estat event
//csdid_plot
estat simple
est clear

csdid BlackDrugRatio, ivar(id) time(Year) gvar(VoteAfterParoleImplemented) notyet
qui: estat event
//csdid_plot
estat simple
est clear

//Effect of Vote After Probation 

replace VoteAfterProbationImplemented = 3000 if VoteAfterProbationImplemented == .
csdid TotalArrest, ivar(id) time(Year) gvar(VoteAfterProbationImplemented) notyet
qui: estat event
//csdid_plot
estat simple
est clear


csdid DrugArrest, ivar(id) time(Year) gvar(VoteAfterProbationImplemented) notyet
qui: estat event
//csdid_plot
estat simple
est clear

csdid BlackTotalRatio, ivar(id) time(Year) gvar(VoteAfterProbationImplemented) notyet
qui: estat event
//csdid_plot
estat simple
est clear

csdid BlackDrugRatio, ivar(id) time(Year) gvar(VoteAfterProbationImplemented) notyet
qui: estat event
//csdid_plot
estat simple
est clear

//Robustness checks

csdid BlackTotalRatio BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct , ivar(id) time(Year) gvar(VoteAfterPrisonImplemented) notyet
qui: estat event
//csdid_plot
estat simple
est clear

csdid BlackDrugRatio BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct , ivar(id) time(Year) gvar(VoteAfterPrisonImplemented) notyet
qui: estat event
//csdid_plot
estat simple
est clear


csdid BlackTotalRatio BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent, ivar(id) time(Year) gvar(VoteAfterPrisonImplemented) notyet
qui: estat event
csdid_plot
estat simple
est clear


csdid BlackDrugRatio BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent, ivar(id) time(Year) gvar(VoteAfterPrisonImplemented) notyet
qui: estat event
csdid_plot
estat simple
est clear




//reverse causality issue
