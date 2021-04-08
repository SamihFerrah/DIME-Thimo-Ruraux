********************************************************************************
********************************************************************************
* 0) Define list of outcomes 
********************************************************************************
********************************************************************************
clear 
set maxvar 32767
pause on 
cd "C:\Users\chmakoug\Dropbox\WB_DRC_Eastern_Recovery\13_endline\02_Thimo Ruraux\07_Data (prestest, pilote, end)\Data of pilote"

	// 1) Import form definition 
	*import excel using "$home/14. Female Entrepreneurship Add on/Survey Instrument/DIME_Tunisia_entrepreneurship_12232020_Encrypted Version.xlsx", sheet("survey") clear first
	
	import excel using "ThimoRuraux_endline_chief_03272021.xlsx", sheet("survey") clear first 
	
	* Gen variable order 
	
	g variable_order =_n 
	
	// 2) Keep interesting type of question
	
	split type, parse(" ")
	
	keep if type == "integer" 					| ///
			type == "begin group"				| ///
			type == "decimal"					| ///
			type1 == "select_one"				| ///
			type == "note"

			
	// 3) Define form section using different modules 

	g 		group_name = ""
	replace group_name = name if type == "begin group"
	replace group_name = group_name[_n-1] if group_name == ""
	
	* Here insert module not needed in outputs 
	drop if group_name == "a1_respondents"					|	///
			group_name == "a1_enumerator"					|	///
			group_name == "a1_datetime"					|	///
			group_name == "a1_city "	|	///
			group_name == "a2_consent"			| 	///
			group_name == "a1_contactperson"					|	///
			group_name == "socioecono_demograph"					| 	///
			group_name == "b1_household_characteristics"			|	///
			group_name == "b1_respondent"		|	///
			group_name == "j_conclusion"

	keep type name labelenglish constraint relevance variable_order
	
	g 		type2 = type 
	replace type2 ="." 	 if type != "begin group"
	
	g 		module = labelenglish 		  if type == "begin group"
	replace module = module[_n-1] 		  if type2 == "."
	
	keep name labelenglish module variable_order
	
	rename labelenglish label
	rename name Variables 
	
	sa "formchef.dta", replace

	
********************************************************************************
********************************************************************************
*				USE DATA AND CREATE SUMMARY STAT
********************************************************************************
********************************************************************************

*forvalue i = 0/1{

*u "$home/14. Female Entrepreneurship Add on/Data/Second Round/cleandata/clean_CashXFollow_noPII.dta", clear 
u "DIME_Thimo-Ruraux_Individual.dta", clear

drop a1_*
drop *date* 
drop j_*
cap drop a1_truerespondant
cap drop a1_notrespondant
cap drop a1_other_notrespondant

* Replace special missing character 

foreach var of varlist _all{

	destring `var', replace 
	
	cap confirm numeric variable `var'
	
	if _rc ==0{
	
		replace `var' =.o if `var' == -99 
		replace `var' =.a if `var' == -8 
		replace `var' =.d if `var' == -9
		replace `var' =.r if `var' == -7 
		
	
	}

}


/*
* Merge with assignment list to identify respondents status (and type of survey)


merge m:1 HHID using "A:/Assignment/Full Sample.dta", gen(assignment) keepusing(HHID Intervention)

cap drop_merge 

keep if assignment == 3

* Create indicator for type of survey 

g 		male_survey = 0
replace male_survey = 1 if Intervention == "Cash Grants - Partenaire"

g 		cash_survey = 0 
replace cash_survey = 1 if Intervention == "Cash Grants - Women"

g 		tclp_survey = 0 
replace tclp_survey = 1 if Intervention == "Follow up - TCLP"



	* Keep appropriate sample 
	drop if male_survey == `i'
*/	
	count 
	
	local tot_obs = `r(N)'
	
/*	
  
  * Naming condition based on sample
	if `i' == 0{
		local shet "Partner"
	}
	if `i' == 1{
		local shet "Cash X Follow"
	}
*/	
	
	* Create local to be filled with numeric variable na,e
	local num_var = ""
	
	* Recode missing variables with special missing indicator
	
	foreach var of varlist _all { 													//loop over all variables

		capture confirm numeric variable `var' 										//check that a variable is numeric
		
		if !_rc{
			
			local num_var = "`num_var' `var'"										// Add `var' to local with all numeric variable
			
		}
	}


	* Keep numeric variable
	
	keep `num_var'

	local all_var ""															// A bit unnecessary as it would end up with the same var as the local num_var		

	foreach var of varlist  _all{

		g s`var' 		= `var'
		g y`var'		= `var'
		g a`var'		= `var'
		g m`var'		= `var'
		
		local all_var "`all_var' `var'"
		
	}
	
	* Count number of variable in local 
	
	local count_obs: word count `all_var'


	* Generate summary stats for each var 
	
	collapse (mean) m* (sd) s* (min) y* (max) a*

	local category "m s y a"

	* Loop over type of summary stat and create tempfile for each 
	
	foreach collapsed of local category{

		preserve 
		
			keep `collapsed'*
			
			rename `collapsed'* * 
			
			tempfile  `collapsed'
			sa		 ``collapsed''

		restore 
	}


	* Loop over each summary stat to rename and prepare dataset for merging all 
	
	foreach collapsed of local category{

		* Condition for naming variables
		if "`collapsed'" == "m"{
			local varname = "Mean"
		}
		if "`collapsed'" == "s"{
			local varname = "StDev"
		}
		if "`collapsed'" == "y"{
			local varname = "Min"
		}
		if "`collapsed'" == "a"{
			local varname = "Max"
		}
		
		* Use tempfile 
		u ``collapsed'', clear

		* Create variables
		g `varname' 		=.
		g Variables 		=""

		* Set observations as the number of numeric variables
		set obs `count_obs'

		local counter = 1
		
		* Fill obs with: Variable names and Statistics from tempfile
		foreach var of varlist _all{

			di in red "`var'"
			
			local stat =  `var'
			
			di in red "`stat'"
			
			replace `varname'  	= `stat' 		if _n == `counter'
			replace Variables 	= "`var'"	  	if _n == `counter'
					
			local counter = `counter' + 1
		}

		* Keep relevant variables (Variable name + Statistic)
		keep `varname' Variables

		* Tempfile
		tempfile  `varname'
		sa		 ``varname''

	}

	* Merge all tempfile with summary stat
	
	u `Mean', clear
	merge 1:1 Variables using `StDev', nogen
	merge 1:1 Variables using `Min', nogen
	merge 1:1 Variables using `Max', nogen


	sa "Statistiques_chef.dta", replace

	********************************************************************************
	********************************************************************************
	********************************************************************************

	* Export to excel
	
	u "Statistiques_chef.dta", clear

	merge 1:1 Variables using "formchef.dta"

	keep if _merge == 3
			
	drop _merge 

	order module Variables label Mean StDev Min Max 

	sort module variable_order

	drop variable_order
		
	export excel using "Data Quality_chef.xlsx", sheet("Statchef", replace) first(var)




	
