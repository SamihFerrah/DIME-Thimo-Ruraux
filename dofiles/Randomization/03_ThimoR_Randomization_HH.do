********************************************************************************
********************************************************************************
*				RANDOMIZATION DO FILE FOR THIMO RURAUX 
********************************************************************************
********************************************************************************
/*

1) Randomly select respondents in each selection method
		
		- 15 respondents per villages in the chief selection
		- 15 respondents per villages in the communautary selection
		- 20 respondents per villages in the random selection (total = 2400)

		
		We will stratify using:
	

*/

********************************************************************************
********************************************************************************
* 0. SET SEED AND OTHER LOCAL GLOBAL
********************************************************************************
********************************************************************************
set seed 02242021 																// (24th February 2021)
		// Definitely set a new seed for this randomisation since it's on a different level
local date = c(current_date)

global run = 10												 // Number of run for the stable test
global output "$path_dropbox/Outputs"
//	since you're using both $run and $output in two do-files it's best to set these
//	in the master script. This makes the code much easier to maintain  

********************************************************************************
********************************************************************************
* 1. MERGE WITH SELECTED VILLAGES
********************************************************************************
********************************************************************************

* Use Thimo ruraux merged data

forvalue i = 1/$run{

	set seed 02242021 							
	
	u "$path_dropbox/THIMOR2018_List_Sampling_noPII.dta", clear
	
	merge m:1 village using "$output/Village_List.dta", keepusing(village)
	
	* Keep respondent in selected villages 
	
	keep if _merge == 3 
	
	drop _merge 
	
	* Drop replacement respondents (will do another draw for them)
	
	drop if treatment_variable == 0
	
	* Define strata 
	
	egen indiv_strata = group (gender auto_pygm depla_refug ex_combatant)
	
	********************************************************************
	* Select 15 respondents per villages in principal / chief selection
	********************************************************************
	
	g select_trt_chief_`i' = 0 if selection_method == "Chief"				    
	
	levelsof village if selection_method == "Chief", local (vil_chief)
	
	foreach community in `vil_chief'{
	
		sort hhidused, stable
		
		sort indiv_strata, stable 
		
		by  indiv_strata : g 		rand_chief = runiform() if village == "`community'"
		
		sort  rand_chief, stable
		
		replace 	select_trt_chief_`i' = 1 if _n <= 15	& village == "`community'"
		
		drop rand_chief
	
	}
	
	********************************************************************
	* Select 15 respondents per villages in communautary selection
	********************************************************************
	
	g select_trt_communautary_`i' = 0 if selection_method == "Community"			    
	
	levelsof village if selection_method == "Community", local (vil_comm)
	
	foreach community in `vil_comm'{
	
		sort hhidused, stable
		sort indiv_strata, stable 
		
		by  indiv_strata : g 		rand_chief = runiform() if village == "`community'"
									// same comment as in 111 in dofile 02_....
		sort  rand_chief, stable
		
		replace 	select_trt_communautary_`i' = 1 if _n <= 15	& village == "`community'"
		
		drop rand_chief
	
	}
	
	********************************************************************
	* Select 20 respondents per villages in lottery selection
	********************************************************************
	
	g select_trt_lottery_`i' = 0 if selection_method == "Lottery"				    
	
	levelsof village if selection_method == "Lottery", local (vil_lott)
	
	foreach community in `vil_lott'{
	
		sort hhidused, stable
		sort indiv_strata, stable 
		
		by  indiv_strata : g 		rand_chief = runiform() if village == "`community'"
									// same comment as in 111 in dofile 02_....		
		sort  rand_chief, stable
		
		replace 	select_trt_lottery_`i' = 1 if _n <= 20	& village == "`community'"
		
		drop rand_chief
	
	}
	
	
	* Stratification test 
	
	tab treatment_variable if select_trt_chief_`i' 			== 1		// are you looking into these as well
	tab treatment_variable if select_trt_communautary_`i' 	== 1		// when you're running the code or did
	tab treatment_variable if select_trt_lottery_`i'		==1			// you just look at it the first time?
	
	reg treatment_variable select_trt_chief_`i', robust
	reg treatment_variable select_trt_communautary_`i', robust
	reg treatment_variable select_trt_lottery_`i', robust
	
	tempfile rand_`i'
	sa 		`rand_`i''
	

}


	* Stable test
	
	forvalue i = 2/$run { 
	
		u `rand_1', clear 
		
		merge 1:1 hhidused using `rand_`i''
	
		assert select_trt_chief_1 			== select_trt_chief_`i'
		assert select_trt_communautary_1 	== select_trt_communautary_`i'
		assert select_trt_lottery_1 		== select_trt_lottery_`i'
		
	}
	
	
/*
Just as a side note, you can code stability checks for randomisations using the 
`cf' command. For that you would save the first iteration (the one you would use)
one time and then run the loop using something like `cf using "Ranomisation output.dta"'.
cf compares both datasets for you and will let you know if something changes.
You just need to make sure you sort the datasets the same way before comparing 
and you won't have to do any manual work and can even compare 1000 iterations
if you need to.
*/

u `rand_1', clear 

keep if select_trt_chief_1 == 1 		| ///
		select_trt_communautary_1 == 1 	| ///
		select_trt_lottery_1 == 1 
		
		tab select_trt_chief_1
		tab select_trt_communautary_1
		tab select_trt_lottery_1
		

decode corridor, g(Corridor)

rename *_1 *
rename village 				Village 
rename selection_method 	Selection
rename province 			Province
rename provinced_id			ID_Province 
rename territoired 			Territoire
rename hhidused				HHID 


* Export village list 

preserve 

	keep  Province Territoire Corridor Village HHID Selection

	order Province Territoire Corridor Village HHID Selection

	sort  Province Territoire Corridor Village HHID Selection

	export excel using 	"$output/Indiv_List_`date'.xlsx"	, replace firstrow(var)

restore 


/* 

* Export Preload

preserve 

rename Noms				nom
rename Phone 			Telephone 
rename Reference_Nom 	Personne_de_Reference
rename Province 		province
rename Territoire 		territoire

encode Village, gen(village)

keep HHID Telephone province territoire Personne_de_Reference Age village Enrollmentdate Adresse nom

export delimited using "$output/thimor`date'.csv", replace





	
	



