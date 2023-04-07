
clear all
use GV482_CourseworkData_2022-23.dta, clear 

//summary statistics 

generate All = 1 
label var All "All years"
foreach y in 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020 2021{
	gen year`y' = 0
	replace year`y' = 1 if Year == `y'
	label var year`y' "`y'" 
}

file open fh using arrests_per_year.tex, write replace 

	file write fh "\begin{center}" _n ///
		"\begin{tabular}{l c c c c c}" _n ///
		"toprule" _n ///
		"& Total Arrests & Total Black Arrests & Drug Arrests & Black Drug Arrests & N \\" _n ///
		"\cline{2-6}" _n
		
	foreach var of varlist All year1999 year2000 year2001 year2002 year2003 year2004 year2005 year2006 year2007 year2008 year2009 year2010 year2011 year2012 year2013 year2014 year2015 year2016 year2017 year2018 year2019 year2020 year2021{
		local label: variable label `var'
		file write fh "\hspace{10pt} `label' "
		foreach col of varlist TotalArrest BlackTotalArrest DrugArrest BlackDrugArrest{
			sum `col' if `var' == 1
			local mean = string(`r(mean)', "%3.2f")
			file write fh "& `mean' "
		}
		
		count if `var ' == 1
		local N = string(`r(N)', "%10.0fc")
		file write fh "& `N' "
		
	file write fh "\\" _n
	
	}
	
	file write fh "\bottomrule" _n ///
	"\end{tabular}" _n ///
	"\begin{tabular}{ p{5.8in} }" _n ///
	"\footnotesize" _n ///
	"Notes: This table reports the mean arrests and drug arrests per year" _n ///
	"\end{tabular}" _n ///
	"\end{center}" _n ///
	
	
	file close fh 
	
		