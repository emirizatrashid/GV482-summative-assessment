clear all
set maxvar 25000
set matsize 11000
* Necessary to perform some commands

cd "C:\Users\WOLTON\Dropbox\LSE\GV482\Discrimination\Problem Sets\Empirical\Data_and_paper"
* Always set the directory first
* Set a path on YOUR computer to run the do file


use discrimination_ps_data.dta, clear



******************* QUESTION 1 *************************************************

generate All = 1
label var All "All years"
* Creating a variable for the whole sample
foreach y in 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013{
	gen year`y' = 0
	* Creating variables for each year
	replace year`y'=1 if year == `y'
	label var year`y' "`y'"
	* Note that I am labeling the variable as well. Always label!
}
	

* Here is another way to report table from stata to latex
file open fh using Stop_per_race.tex, write replace 
* First create a file

* The command below tell stata what to write
* Between " " you have the text
* _n tells stata to go to the line in the file you are writing on
* /// tells stata that the command is broken over several lines

	file write fh "\begin{center}" _n ///
	* I am telling stata: On this file you have opened, please write "\begin{center}"
	* Then go to the line (command _n) and then I say the command is not over (the ///)
		"\begin{tabular}{l c c c c c c }" _n ///
	* Now I am telling to write "\begin{tabular}{l c c c c c c }", to go to the line (_n),
	* and the command is not over /// (etc. etc.)
		"\toprule" _n ///
		"&  White & Black & Hispanic & Asian & Other & N \\" _n ///
		"\cline{2-7}  \\" _n  

		
	foreach var of varlist All year2003 year2004 year2005 year2006 year2007 year2008 year2009 year2010 year2011 year2012 year2013 {
* I am starting a loop over several variables
* The loop says for each of the variables All, year2003, take one variable and perform the following
* When you are done, take the next variable on the list and perform the following, etc.
	local label: variable label `var' 
* Store a label locally for one loop

	file write fh "\hspace{10pt} `label' "
* We write the label on the file	

	foreach col of varlist swhite sblack shisp sasian sother {
* Now we do loops over the variable we care about (ethnic composition) 		
		sum `col' if `var'==1
* We summarize 
		local mean = string(`r(mean)', "%3.2f")
* We keep the mean in a string format with 2 decimals
* This is to make it real pretty!
		file write fh "& `mean' "
* We write the mean in the file		
		}
* Here I close the loop for all the ethnic categories
		
		count if `var'==1
* We count the number of observations
		local N = string(`r(N)', "%10.0fc")
* We store it as a variable with 10 numbers and no decimal
		
		file write fh "& `N' "
* We write the number on the file

	file write fh "\\" _n
* We tell the file we go to the line and we tell stata we go to the line
	}
* We close the first loop (the one about variables)
* Loops are a good way to go fast in your code! Learn how to do them to save time
* If you find it too difficult, you can always copy paste the code, one for each variable

	file write fh "\bottomrule " _n ///
		"\end{tabular}" _n ///
		"\begin{tabular}{ p{5.8in} }" _n ///
		"\footnotesize" _n ///
		"Notes: This table reports the distribution of stops by ethnicity for the whole sample and for each year." _n ///
		"\end{tabular}" _n ///
		"\end{center}" _n 
* We finish the document, writing a bunch of latex commands so that I can
* simply import it into my latex file
* Note that this file write does not have to be a latex file.
* You can use other formats
		
	file close fh
* We close the file

* This code is copy pasted from Fryer's replication file (who did not create it)

*************** QUESTION 2 *****************************************************



	file open fh using StopReason_per_race.tex, write replace 
* First create a file

* We are going to do a very similar process as above. So please refer to the
* previous questions for details.

	file write fh "\begin{center}" _n ///
		"\begin{tabular}{l c c c c c c c }" _n ///
		"\toprule" _n ///
		"& (1) & & (2) & (3) & (4) & (5) & (6) \\" _n ///
		"& \% used & of which &  White & Black & Hispanic & Asian & Other  \\" _n ///
		"\cline{2-8}  \\" _n  

		
	foreach var of varlist suspmovements crimattire carrysuspobj concealsuspobj fitreldescr prepforcrime lookout appdrugtrans engageviolcrime othersuspbehav {
* I am starting a loop over several variables
	local label: variable label `var' 
* Store a label locally for one loop

	file write fh "\hspace{3pt} `label' "
* We write the label on the file	

	qui sum `var' 
* We summarize the use of violence 
		local mean = string(`r(mean)', "%3.2f")
* We keep the mean in a string format with 2 decimals
		file write fh "& `mean' &   "
		* We leave a column of space for the 

	foreach col of varlist swhite sblack shisp sasian sother {
* Now we do loops over the variable we care about (ethnic composition) 		
		qui sum `col' if `var'==1
* We summarize 
		local mean = string(`r(mean)', "%3.2f")
* We keep the mean in a string format with 2 decimals
		file write fh "& `mean' "
* We write the mean in the file		
		}

		

	file write fh "\\" _n
* We tell the file we go to the line and we tell stata we go to the line
	}


	file write fh "\bottomrule " _n ///
		"\end{tabular}" _n ///
		"\begin{tabular}{ p{5.8in} }" _n ///
		"\footnotesize" _n ///
		"Notes: This table reports the percentage of observation for each stop justification in column (2).  The decomposition by ethnicity is in columns (2)-(6)." _n ///
		"\end{tabular}" _n ///
		"\end{center}" _n 
* We finish the document
		
	file close fh
* We close the file





*************** QUESTION 3 *****************************************************


	file open fh using Force_per_race.tex, write replace 
* First create a file


	file write fh "\begin{center}" _n ///
		"\begin{tabular}{l c c c c c c c }" _n ///
		"\toprule" _n ///
		"& (1) & & (2) & (3) & (4) & (5) & (6) \\" _n ///
		"& \% used & of which &  White & Black & Hispanic & Asian & Other  \\" _n ///
		"\cline{2-8}  \\" _n  

		
	foreach var of varlist useanyforce_other useanyforce force_hands force_wall force_handcuff_orig force_drawweap force_ground force_pointweap force_batonorpepspray {
* I am starting a loop over several variables
	local label: variable label `var' 
* Store a label locally for one loop

	file write fh "\hspace{3pt} `label' "
* We write the label on the file	

	qui sum `var' 
* We summarize the use of violence 
		local mean = string(`r(mean)', "%3.2f")
* We keep the mean in a string format with 2 decimals
		file write fh "& `mean' &   "
		* We leave a column of space for the 

	foreach col of varlist swhite sblack shisp sasian sother {
* Now we do loops over the variable we care about (ethnic composition) 		
		qui sum `col' if `var'==1
* We summarize 
		local mean = string(`r(mean)', "%3.2f")
* We keep the mean in a string format with 2 decimals
		file write fh "& `mean' "
* We write the mean in the file		
		}

		

	file write fh "\\" _n
* We tell the file we go to the line and we tell stata we go to the line
	}


	file write fh "\bottomrule " _n ///
		"\end{tabular}" _n ///
		"\begin{tabular}{ p{5.8in} }" _n ///
		"\footnotesize" _n ///
		"Notes: This table reports the percentage of observation with use of a certain level of violence in column (2).  The decomposition by ethnicity is in columns (2)-(6)." _n ///
		"\end{tabular}" _n ///
		"\end{center}" _n 
* We finish the document
		
	file close fh
* We close the file


*************************** QUESTION 4 *****************************************

* The code below is a slight rearrangement from Fryer's replication code

destring datestop_month datestop_day, generate(month day)
* Month and date of stops are strings, now transformed into float
egen pct_yr = group(pct year) 
* this creates a specific id for each combination of precinct and year
egen pct_yr_month = group(pct year month) 
* this creates a specific id for each combination of precinct and year and month
* I will not run this part of the code as it is too time consuming (as mentionned
* in the text of the problem set). But I will let you know how to run it
* at your own peril...
gen sage_2=sage*sage
* Age squared


global srace "sblack shisp sasian sother"
global sdemo "smale sage sage_2"
global echar "indoors daytime hicrimearea hicrimetime hicrimeareaXtime inuniform idphoto idverbal idrefused idother withothers"
global sbeh  "carrysuspobj fitreldescr prepforcrime lookout crimattire appdrugtrans suspmovements engageviolcrime concealsuspobj othersuspbehav"
global others "frisked searched arrested summonsed foundcontraorweap"
global fe 	  "i.year i.pct"
global p_yr       "i.pct_yr" 
global p_yr_m     "i.pct_yr_month" 
* The commands above create name for groups of variables
* This is useful as it allows us to have an idea of what we are adding
* The disadvantage is that stata stores the name only for one go
* So we have to copy paste this name all over the place
* You will see them pop up again.

local row1 "$srace"
local row2 "$srace $sdemo"
local row3 "$srace $sdemo $echar"
local row4 "$srace $sdemo $echar $sbeh"
local row5 "$srace $sdemo $echar $sbeh $fe"
local row6 "$srace $sdemo $echar $sbeh $p_yr"
local row7 "$srace $sdemo $echar $sbeh $p_yr_m"
* same here (the two steps could be combined into one)

local label1 "(a) & No Controls"
local label2 "(b) & + Civilian Demographics"
local label3 "(c) & + Encounter Characteristics"
local label4 "(d) & + Civilian Behavior"
local label5 "(e) & + Precinct FE, Year FE"
local label6 "(f) & + Precinct*Year FE"
local label7 "(g) & + Precinct*Year*Month FE"
* Here we also create names that will prove useful when we create the table
* This is again an aesthetic choice. It is painful to format tables so I want you
* to know how your stata code can do it for you! 


file open fh using Force_logit.tex, write replace 
* As before, we open our tex file

file write fh 	"\begin{center}" _n ///
	"\begin{tabular}{l l c c c c c}" _n ///
	"\toprule" _n ///
	"& & White Mean & Black & Hispanic & Asian & Other Race  \\" _n ///
	"\cline{3-7}  " _n ///
	"& & (1) & (2) & (3) & (4) & (5) \\" _n ///
	"\cline{3-7}  \\ " _n 
* We write the beginning of the table
* And then we start to loop
forval i = 1/6 {
* We have 6 regressions to do (adding controls from one to the next)
* Hence we are creating a loop for each regression
* If you want to add the regression with mont_year_pct fixed effects, replace 6 by 7

display `i'
* The loop is long so I wanted to know where I was in the loop. I added this
* to learn which loop stata was doing. So it gives 1 for the first loop, 2 for the second, ...

	if `i'==1 {
	qui sum useanyforce if swhite==1
	local mean = string(`r(mean)', "%4.3f")
	}
	* This command will write the mean of use of force for whites
	if `i'>1 {
	local mean = ""
	}
	* This tells stata, do not save anything after the first row
	* Note that this is just to make it pretty

	qui logit useanyforce `row`i'' , cluster(pct)
	* Here we perform our logit for each regression. Each row is a set of controls
	* as defined above (see row1 row2 ...)
	* Note the clustering at the precinct level
	* I use quietly as I do not want to see the results on the screen
	* Because row1, row2,... as well as 1, 2, 3,... are local variables (saved for this command only)
	* we use `.' to inform stata to look into local variables, not the one defined
	* Since both row and i are local we have `row`i''
	
	* The next loop is a way to save the result
		foreach race in black hisp asian other {
		local r = substr("`race'", 1, 1)
		* Not very necessary but create a local variable with race denoted by its first later
		
		local b_`r' = string((exp(_b[s`race'])/(1+exp(_b[s`race'])))/(1-exp(_b[s`race'])/(1+exp(_b[s`race']))),"%4.3f")
		* This computes the odd ratio as pointed out in the text of the problem set and save it
		* One for each race
		local se_`r' = "("+string(exp(_b[s`race']) *_se[s`race'], "%4.3f")+")"
		* This computes the standard errors
		* Below I show you how to get the stars with 2*normal(-abs(_b[s`race']/_se[s`race'])) the p value
		if 2*normal(-abs(_b[s`race']/_se[s`race'])) >.1 { 
		local star_`r' = ""    
		}
		if 2*normal(-abs(_b[s`race']/_se[s`race'])) >.05 & 2*normal(-abs(_b[s`race']/_se[s`race'])) <=.1  {
		local star_`r' = "$^{*}$"   
		}
		if 2*normal(-abs(_b[s`race']/_se[s`race'])) >.01 & 2*normal(-abs(_b[s`race']/_se[s`race'])) <=.05  { 
		local star_`r' = "$^{**}$" 
		}
		if 2*normal(-abs(_b[s`race']/_se[s`race'])) <=.01  {
		local star_`r' = "$^{***}$" 
		}
		
		}
		
	file write fh "`label`i'' & `mean' & `b_b'`star_b' &`b_h'`star_h' &`b_a'`star_a' &`b_o'`star_o' \\" _n
	file write fh " 	&	  &		   & `se_b' &`se_h' &`se_a' &`se_o' \\ " _n
* Now we write our results in the table. Note that we write our results horizontally
* Rather than vertically	
	}
* The commands below complete the document
file write fh 	"\bottomrule " _n ///
	"\end{tabular}" _n ///
	"\begin{tabular}{ p{5.8in} }" _n ///
	"\footnotesize" _n ///
	"Notes: This table reports odds ratios by running logistic regressions. The dependent variable"_n ///
	"is an indicator for whether the police reported using any force during a stop and frisk interaction."_n ///
	"The omitted race is white, and the omitted ID type is other. The first column gives the unconditional"_n ///
	"average of stop and frisk interactions that reported any force being used for white civilians."_n ///
	"Columns (2)-(5) report logistic estimates for black, Hispanic, Asian, and other race civilians, respectively."_n ///
	"Each row corresponds to a different empirical specification. The first row includes solely racial group dummies."_n ///
	"The second row adds controls for gender and a quadratic in age. The third row adds controls for whether the"_n ///
	"stop was indoors or outdoors, whether the stop took place during the daytime, whether the stop took place in a high"_n ///
	"crime area, during a high crime time, or in a high crime area at a high crime time, whether the officer was in uniform,"_n  ///
	"civilian ID type, and whether others were stopped during the interaction. The fourth row adds controls for civilian"_n ///
	"behavior. The fifth row adds precinct and year fixed effects. The sixth row adds precinct* year fixed effects."_n //////
	"Standard errors, clustered at the precinct level, are reported in parentheses." _n ///
 	"\end{tabular}" _n ///
	"\end{center}" _n 
	
file close fh


**************************** QUESTION 5 ****************************************


* Produce the Table 

global srace "sblack shisp sasian sother"
global sdemo "smale sage sage_2"
global echar "indoors daytime hicrimearea hicrimetime hicrimeareaXtime inuniform idphoto idverbal idrefused idother withothers"
global sbeh  "carrysuspobj fitreldescr prepforcrime lookout crimattire appdrugtrans suspmovements engageviolcrime concealsuspobj othersuspbehav"
global others "frisked searched arrested summonsed foundcontraorweap"
global fe 	  "i.year i.pct"
global p_yr       "i.pct_yr" 
global p_yr_m     "i.pct_yr_month" 
* The commands above create name for groups of variables

local row1 "$srace"
local row2 "$srace $sdemo"
local row3 "$srace $sdemo $echar"
local row4 "$srace $sdemo $echar $sbeh"
local row5 "$srace $sdemo $echar $sbeh $fe"
local row6 "$srace $sdemo $echar $sbeh $p_yr"
local row7 "$srace $sdemo $echar $sbeh $p_yr_m"
* same here (the two steps could be combined into one)

local label1 "(a) & No Controls"
local label2 "(b) & + Civilian Demographics"
local label3 "(c) & + Encounter Characteristics"
local label4 "(d) & + Civilian Behavior"
local label5 "(e) & + Precinct FE, Year FE"
local label6 "(f) & + Precinct*Year FE"
local label7 "(g) & + Precinct*Year*Month FE"
* Here we also create names that will prove useful when you 
* As before we won't do the last regression

file open fh using Force_OLS.tex, write replace 
* As before, we open our tex file

file write fh 	"\begin{center}" _n ///
	"\begin{tabular}{l l c c c c c}" _n ///
	"\toprule" _n ///
	"& & White Mean & Black & Hispanic & Asian & Other Race  \\" _n ///
	"\cline{3-7}  " _n ///
	"& & (1) & (2) & (3) & (4) & (5) \\" _n ///
	"\cline{3-7}  \\ " _n 
* We write the beginning of the table
* And then we start to loop
forval i = 1/6 {
* We have 6 regressions to do (adding controls from one to the next)
* Hence we are creating a loop for each regression
* Replace 6 by 7 if you want to add the month_year_pct fixed effects
display `i'

	if `i'==1 {
	qui sum useanyforce if swhite==1
	local mean = string(`r(mean)', "%4.3f")
	}
	* Thismcommand will write the mean of use of force for whites
	if `i'>1 {
	local mean = ""
	}
	* This tells stata, do not save anything after the first row
	* Note that this is just to make it pretty

	qui reg useanyforce `row`i'' , cluster(pct)
	* Here we perform our OLS for each regression. Each row is a set of controls
	* as defined above (see row1 row2 ...)
	* Note the clustering at the precinct level
	* I use quietly as I do not want to see the results on the screen
	* Pay attention to how the dependent variables are written (the `.' again)
	
	* The next loop is a way to save the result
		foreach race in black hisp asian other {
		local r = substr("`race'", 1, 1)
		* Not very necessary but replace race by its first later
		
		local b_`r' = string(_b[s`race'],"%4.3f")
		* This computes the odd ratio as pointed out in the text of the problem set and save it
		* One for each race
		local se_`r' = "("+string(_se[s`race'], "%4.3f")+")"
		* This computes the standard errors and add parentheses 
local tstat_`r' = _b[s`race']/_se[s`race']
	* this is the tstat
.
* Here I try again to get the p-value.
* The p-value is obtained via t-test from the Student-distribution
* The command ttail(e(df_r),abs(`tstat_`r'')) tells stata: give me the T score
* for the case of a regression with e(df_r) degrees of freedom and a t-test
* in absolute values equal to tstat_r (note the `.' again!)
* We multiply by 2 since we do two-tailed t-test
if 2*ttail(e(df_r),abs(`tstat_`r'')) >.1 { 
		local star_`r' = ""    
		}
if 2*ttail(e(df_r),abs(`tstat_`r'')) >.05 & 2*ttail(e(df_r),abs(`tstat_`r'')) <=.1  {
		local star_`r' = "$^{*}$"   
		}
if 2*ttail(e(df_r),abs(`tstat_`r'')) >.01 & 2*ttail(e(df_r),abs(`tstat_`r'')) <=.05  { 
		local star_`r' = "$^{**}$" 
		}
if 2*ttail(e(df_r),abs(`tstat_`r'')) <=.01  {
		local star_`r' = "$^{***}$" 
		}
* we are creating the stars as before adjusting for the p-value formula
		
		}
		
	file write fh "`label`i'' & `mean' & `b_b'`star_b' &`b_h'`star_h' &`b_a'`star_a' &`b_o'`star_o' \\" _n
	file write fh " 	&	  &		   & `se_b' &`se_h' &`se_a' &`se_o' \\ " _n
* Now we write our results in the table. Note that we write our results horizontally
* Rather than vertically	
	}
* The commands below complete the document
file write fh 	"\bottomrule " _n ///
	"\end{tabular}" _n ///
	"\begin{tabular}{ p{5.8in} }" _n ///
	"\footnotesize" _n ///
	"Notes: The table reports the coefficients from an OLS regression. The dependent variable" _n ///
	"is an indicator for whether the police reported using any force during a stop and frisk interaction." _n /// ///
	"The omitted race is white, and the omitted ID type is other. The first column gives the unconditional" _n /// ///
	"average of stop and frisk interactions that reported any force being used for white civilians." _n /// ///
	"Columns (2)-(5) report OLS estimates for black, Hispanic, Asian, and other race civilians, respectively." _n /// ///
	"Each row corresponds to a different empirical specification. The first row includes solely racial group dummies." _n /// ///
	"The second row adds controls for gender and a quadratic in age. The third row adds controls for whether the" _n /// ///
	"stop was indoors or outdoors, whether the stop took place during the daytime, whether the stop took place in a high" _n /// ///
	"crime area, during a high crime time, or in a high crime area at a high crime time, whether the officer was in uniform," _n ///  ///
	"civilian ID type, and whether others were stopped during the interaction. The fourth row adds controls for civilian" _n /// ///
	"behavior. The fifth row adds precinct and year fixed effects. The sixth row adds precinct* year fixed effects." _n /// ///
	"Standard errors, clustered at the precinct level, are reported in parentheses." _n ///
 	"\end{tabular}" _n ///
	"\end{center}" _n 
	
file close fh

