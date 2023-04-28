//redirect
//cd ""								//set your own directory
ssc install csdid
ssc install drdid
ssc install reghdfe
net install ddtiming, from(https://tgoldring.com/code/)
net install honestdid, from("https://raw.githubusercontent.com/mcaceresb/stata-honestdid/main") replace
honestdid _plugin_check
clear all
use GV482_CourseworkData_2022-23.dta, clear 

//creating the new variable which is the ratio of black to total arrests

gen BlackTotalRatio = BlackTotalArrest/TotalArrest
gen BlackDrugRatio = BlackDrugArrest/DrugArrest
label variable BlackTotalRatio "Black Arrests to Total Arrests Ratio"
label variable BlackDrugRatio "Black Drug Arrests to Total Drug Arrests Ratio"

//summary statistics 
/*
qui estpost sum TotalArrest BlackTotalArrest DrugArrest BlackDrugArrest BlackTotalRatio BlackDrugRatio, d
esttab using "summary_stats.tex", tex cells("count(label(Obs.)) mean(fmt(3) label(Mean))  sd(fmt(3) label(St. Dev.)) min(fmt(3) label(Min.)) max(fmt(3) label(Max.))")  replace label nonum noobs
*/
est clear 

//preserve
//collapse (mean) TotalArrest BlackTotalRatio DrugArrest BlackDrugRatio, by(Year)

//to produce the graph
//twoway line TotalArrest Year || line DrugArrest Year  
//twoway line BlackTotalRatio Year || line BlackDrugRatio Year 
//restore

//OLS regression

//start with the voting after prison



preserve
keep if BlackTotalRatio != .
sum BlackTotalRatio
drop if BlackTotalArrest == .
sum BlackTotalArrest
keep if BlackPct != .
gen black_disparity = BlackTotalRatio-BlackPct/100
sum black_disparity
restore

preserve
keep if BlackDrugRatio != .
sum BlackDrugRatio
sum BlackDrugArrest
keep if BlackPct != .
gen blackdrugdisparity = BlackDrugRatio - BlackPct/100
sum blackdrugdisparity
restore

est clear
qui eststo: reg TotalArrest VoteAfterPrison
qui eststo: reg TotalArrest VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg TotalArrest VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg TotalArrest VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies
/*
esttab using "vote_after_prison_arrest.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterPrison) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Total Arrests Per Capita", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})
*/


est clear

qui eststo: reg DrugArrest VoteAfterPrison
qui eststo: reg DrugArrest VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg DrugArrest VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg DrugArrest VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies

/*
esttab using "vote_after_prison_drugarrest.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterPrison) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Drug Arrest Per Capita", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})
*/
est clear

qui eststo: reg BlackTotalRatio VoteAfterPrison
qui eststo: reg BlackTotalRatio VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg BlackTotalRatio VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg BlackTotalRatio VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies
/*
esttab using "vote_after_prison_BlackTotalRatio.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterPrison) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Black to Total Arrest Ratio", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})
*/
est clear

qui eststo: reg BlackDrugRatio VoteAfterPrison
qui eststo: reg BlackDrugRatio VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg BlackDrugRatio VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg BlackDrugRatio VoteAfterPrison BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies

/*
esttab using "vote_after_prison_BlackDrugRatio.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterPrison) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Black to Total Drug Arrest Ratio", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})
*/
est clear




//Now for vote after parole

est clear
qui eststo: reg TotalArrest VoteAfterParole
qui eststo: reg TotalArrest VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg TotalArrest VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg TotalArrest VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies

/*
esttab using "voter_after_parole_arrest.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterParole) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Total Arrests Per Capita", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})

*/

est clear

qui eststo: reg DrugArrest VoteAfterParole
qui eststo: reg DrugArrest VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg DrugArrest VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg DrugArrest VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies

/*
esttab using "did_control_table.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterParole) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Drug Arrest Per Capita", pattern(1 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})
*/
est clear

qui eststo: reg BlackTotalRatio VoteAfterParole
qui eststo: reg BlackTotalRatio VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg BlackTotalRatio VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg BlackTotalRatio VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies
/*
esttab using "vote_after_parole_BlackTotalRatio.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterParole) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Black to Total Arrest Ratio", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})
*/
est clear

qui eststo: reg BlackDrugRatio VoteAfterParole
qui eststo: reg BlackDrugRatio VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg BlackDrugRatio VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg BlackDrugRatio VoteAfterParole BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies
/*
esttab using "vote_after_parole_BlackDrugRatio.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterParole) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Black to Total Drug Arrest Ratio", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})
*/
est clear




//Now vote after probation

est clear
qui eststo: reg TotalArrest VoteAfterProbation
qui eststo: reg TotalArrest VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg TotalArrest VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg TotalArrest VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies

/*

esttab using "voter_after_probation_arrest.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterProbation) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Total Arrests Per Capita", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})
*/
est clear 



qui eststo: reg DrugArrest VoteAfterProbation
qui eststo: reg DrugArrest VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg DrugArrest VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg DrugArrest VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies

/*
esttab using "voter_after_probation_drugarrest.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterProbation) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Drug Arrest Per Capita", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})
*/
est clear


est clear 
qui eststo: reg BlackTotalRatio VoteAfterProbation
qui eststo: reg BlackTotalRatio VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg BlackTotalRatio VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg BlackTotalRatio VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies

/*

esttab using "vote_after_probation_BlackTotalRatio.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterProbation) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Black to Total Arrest Ratio", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})
*/
est clear

qui eststo: reg BlackDrugRatio VoteAfterProbation
qui eststo: reg BlackDrugRatio VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct 
qui eststo: reg BlackDrugRatio VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent
qui eststo: reg BlackDrugRatio VoteAfterProbation BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp Gov_dem Gov_ind Gov_rep Leg_dem Leg_div Agencies

/*
esttab using "vote_after_probation_BlackDrugRatio.tex", replace ///
b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
keep(VoteAfterProbation) ///
label booktabs nonotes noobs nomtitle collabels(none) ///
scalars("N Obs") sfmt(0) ///
mgroups("Black to Total Drug Arrest Ratio", pattern(1 0 0 0) ///
prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  alignment(D{.}{.}{-1})
*/
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

csdid BlackTotalRatio , ivar(id) time(Year) gvar(VoteAfterPrisonImplemented) 
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
//csdid_plot
estat simple
est clear


csdid BlackDrugRatio BlackPct HispPct BlackPct_2000 HispPct_2000 Under19Pct Over65Pct GDPpercapita Growth Unemp SurplusDeficitPercent, ivar(id) time(Year) gvar(VoteAfterPrisonImplemented) notyet
qui: estat event
//csdid_plot
estat simple
est clear

//Rhode Island and Maryland
/*
csdid BlackTotalRatio, ivar(id) time(Year) gvar(VoteAfterPrisonImplemented) notyet
//qui: csdid_stats attgt, wboot rseed(1)
csdid_plot, group(2006) name(m1, replace) title("Rhode Island")
csdid_plot, group(2016) name(m2, replace) title("Maryland")
csdid_plot, group(2018) name(m3, replace) title("New York")
csdid_plot, group(2019) name(m4, replace) title("CO, NJ, NV")
graph combine m1 m2 m3 m4, xcommon scale(0.8)

csdid BlackDrugRatio, ivar(id) time(Year) gvar(VoteAfterPrisonImplemented) notyet
//qui: csdid_stats attgt, wboot rseed(1)
csdid_plot, group(2006) name(m5, replace) title("Rhode Island")
csdid_plot, group(2016) name(m6, replace) title("Maryland")
csdid_plot, group(2018) name(m7, replace) title("New York")
csdid_plot, group(2019) name(m8, replace) title("CO, NJ, NV")
graph combine m5 m6 m7 m8, xcommon scale(0.8)
*/

//sensitivity analysis
preserve
qui sum Year, meanonly
replace VoteAfterPrisonImplemented = cond(mi(VoteAfterPrisonImplemented), r(max) + 1, VoteAfterPrisonImplemented)
qui csdid BlackDrugRatio, ivar(id) time(Year) gvar(VoteAfterPrisonImplemented) notyet
csdid_estat event, estore(csdid)
estimates restore csdid

local plotopts xtitle(Mbar) ytitle(95% Robust CI)
honestdid, pre(3/24) post(25/38) mvec(0(0.5)2) 
restore

qui sum Year, meanonly
replace VoteAfterPrisonImplemented = cond(mi(VoteAfterPrisonImplemented), r(max) + 1, VoteAfterPrisonImplemented)
csdid BlackTotalRatio, ivar(id) time(Year) gvar(VoteAfterPrisonImplemented) notyet
csdid_estat event, estore(csdid)
estimates restore csdid

local plotopts xtitle(Mbar) ytitle(95% Robust CI)
honestdid, pre(3/24) post(25/38) mvec(0(0.5)2) 


est clear

//reverse causality issue


qui eststo: reg VoteAfterPrison TotalArrest
qui eststo: reg VoteAfterParole TotalArrest 
qui eststo: reg VoteAfterProbation TotalArrest 
/*
esttab using "total_arrest_reverse.tex", replace   ///
 b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
 label booktabs nonotes noobs nomtitle collabels(none)  ///
 mgroups("Vote After Prison" "Vote After Parole" "Vote After Probation", pattern(1 1 1) ///
 prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) alignment(D{.}{.}{-1})
*/
//
est clear
qui eststo: reg VoteAfterPrison DrugArrest
qui eststo: reg VoteAfterParole DrugArrest 
qui eststo: reg VoteAfterProbation DrugArrest 
/*
esttab using "drug_arrest_reverse.tex", replace   ///
 b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
 label booktabs nonotes noobs nomtitle collabels(none)  ///
 mgroups("Vote After Prison" "Vote After Parole" "Vote After Probation", pattern(1 1 1) ///
 prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) alignment(D{.}{.}{-1})

*/
//
est clear
qui eststo: reg VoteAfterPrison BlackTotalRatio
qui eststo: reg VoteAfterParole BlackTotalRatio 
qui eststo: reg VoteAfterProbation BlackTotalRatio 
/*
esttab using "blacktotalratio_reverse.tex", replace   ///
 b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
 label booktabs nonotes noobs nomtitle collabels(none)  ///
 mgroups("Vote After Prison" "Vote After Parole" "Vote After Probation", pattern(1 1 1) ///
 prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) alignment(D{.}{.}{-1})*/
 
est clear
qui eststo: reg VoteAfterPrison BlackDrugRatio 
qui eststo: reg VoteAfterParole BlackDrugRatio 
qui eststo: reg VoteAfterProbation BlackDrugRatio
/*
esttab using "blackdrugratio_reverse.tex", replace   ///
 b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
 label booktabs nonotes noobs nomtitle collabels(none)  ///
 mgroups("Vote After Prison" "Vote After Parole" "Vote After Probation", pattern(1 1 1) ///
 prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) alignment(D{.}{.}{-1})
*/


