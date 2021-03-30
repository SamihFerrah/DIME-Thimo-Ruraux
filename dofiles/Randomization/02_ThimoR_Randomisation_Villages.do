********************************************************************************
********************************************************************************
*				RANDOMIZATION DO FILE FOR THIMO RURAUX 
********************************************************************************
********************************************************************************
/*

1) 	Randomly select a subset of village in each treatment:
	
		- 65 villages in principal selection
		- 65 villages in communautary selection
		- 120 villages random selection
	
	We will stratify using geographical variable:
		
		- Province
		- Territory
		- Corridor
	
2) Randomly select respondents in each selection method
		
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
		// good to include where the seed comes from (URL). Also if you set this in a
		// local you can just call the local in line 55
		
local date = c(current_date)

global run = 10													// Number of simulation run for stable test
	// unless $run needs to be used in another do file, use a local. 
global output "$path_dropbox/Outputs"
********************************************************************************
********************************************************************************
* 1. SELECT VILLAGES
********************************************************************************
********************************************************************************

* Use Thimo ruraux merged data

forvalue i = 1/$run{

	set seed 02242021 							
	
	u "$path_dropbox/THIMOR2018_List_Sampling_noPII.dta", clear

	g count_hh = 1
	
	collapse (sum) count_hh, by(village selection_method province provinced_id territoired corridor)
	
	*keep village selection_method province provinced_id territoired corridor

	duplicates drop 

	tab selection_method

	sort village, stable 

	* Create variable for villages with less than the targeted sample size
	
	g 		less_sample = 0 
	replace less_sample = 1 if count_hh < 15
	
	* Drop pilot villages
		// the combination of village name, gender, land holding and incoe size might
		// be enough to identify some of the individuals. For reproduction/publishing
		// This should probably be taken out and no village names included in the code
	
	drop if village == "RUSHOGA" 
	drop if village == "MEMA"
	drop if village == "KACHEHEMBE"
	
	
	* Define strata group 

	egen village_strata = group(province territoired corridor less_sample)

	********************************************************************
	* Select 65 villages in principal / chief selection
	********************************************************************
	
	sort village_strata, stable 
	
	by village_strata: g 		rand_chief = runiform() if selection_method == "Chief"
	
	sort 	rand_chief, stable
	
	g		select_trt_chief_`i' = 0			 if selection_method == "Chief"
	replace select_trt_chief_`i' = 1 if _n <= 65 &  selection_method == "Chief"
	
	********************************************************************
	* Select 65 villages in communautary selection
	********************************************************************
	
	sort village_strata, stable 
	
	by village_strata: g 		rand_communautary = runiform() if selection_method == "Community"
								// Using the same seed again is generally fine but
								// the resulting randomisations won't be independent.
								// For the randomisation to be independent set a new seed						
		
	sort 	rand_communautary, stable
	
	g		select_trt_communautary_`i' = 0				if selection_method == "Community"
	replace select_trt_communautary_`i' = 1 if _n <= 65  & selection_method == "Community"
	
	********************************************************************
	* Select 120  villages in lottery selection
	********************************************************************
	
	sort village_strata, stable 
	
	by village_strata:  g 		rand_lottery = runiform() if selection_method == "Lottery"
								// same comment as line 111
	sort 	rand_lottery, stable
	
	g		select_trt_lottery_`i' = 0				if selection_method == "Lottery"
	replace select_trt_lottery_`i' = 1 if _n <= 130 &  selection_method == "Lottery"
	
	
	* Stratification test 
	
	tab village_strata if select_trt_chief_`i' 			== 1
	tab village_strata if select_trt_communautary_`i' 	== 1
	tab village_strata if select_trt_lottery_`i'		== 1
	
	reg village_strata select_trt_chief_`i', robust
	reg village_strata select_trt_communautary_`i', robust
	reg village_strata select_trt_lottery_`i', robust
	
	tempfile rand_`i'
	sa 		`rand_`i''

}

	* Stable test
	
	forvalue i = 2/$run { 
	
		u `rand_1', clear 
		
		merge 1:1 village province using `rand_`i''
	
		assert select_trt_chief_1 			== select_trt_chief_`i'
		assert select_trt_communautary_1 	== select_trt_communautary_`i'
		assert select_trt_lottery_1 		== select_trt_lottery_`i'
		
	}


* Export list of village selected

u `rand_1', clear 

keep if select_trt_chief_1 == 1 		| ///
		select_trt_communautary_1 == 1 	| ///
		select_trt_lottery_1 == 1 

decode corridor, g(Corridor)

rename *_1 *
rename village 				Village 
rename selection_method 	Selection
rename province 			Province
rename provinced_id			ID_Province 
rename territoired 			Territoire

keep  Province Territoire Corridor Village Selection

order Province Territoire Corridor Village Selection

sort  Province Territoire Corridor Selection, stable

* Export village list 

export excel using 	"$output/Village_List_`date'.xlsx"	, firstrow(var) replace 

rename Village 		village 
rename Selection 	selection_method

keep village selection_method

sa 			 		"$output/Village_List.dta"			, replace


* Export list of villae not selected	
	
u `rand_1', clear 

keep if select_trt_chief_1 == 0 		| ///
		select_trt_communautary_1 == 0 	| ///
		select_trt_lottery_1 == 0 

decode corridor, g(Corridor)

rename *_1 *
rename village 				Village 
rename selection_method 	Selection
rename province 			Province
rename provinced_id			ID_Province 
rename territoired 			Territoire

keep  Province Territoire Corridor Village Selection

order Province Territoire Corridor Village Selection

sort  Province Territoire Corridor Selection, stable

* Export village list 

export excel using 	"$output/Village_List_Not_Selected_`date'.xlsx"	,firstrow(var) replace 

rename Village 		village 
rename Selection 	selection_method
