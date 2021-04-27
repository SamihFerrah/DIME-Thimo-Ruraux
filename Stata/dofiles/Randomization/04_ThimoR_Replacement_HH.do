********************************************************************************
********************************************************************************
* 				THIMO RURAUX REPLACEMENT SELECTION
********************************************************************************
********************************************************************************
set seed 04262021
local date = c(current_date)

* Use full list of available 
u "$path_dropbox/03_sampling/THIMOR2018_List_Sampling.dta", clear


rename *_1 *
decode corridor, g(Corridor)
rename village 				Village 
rename selection_method 	Selection
rename province 			Province
rename provinced_id			ID_Province 
rename territoired 			Territoire
rename hhidused				HHID 

keep Noms Province Territoire Corridor Village HHID Selection

* Merge with list of selected respondent as part of the principal sample
preserve 

	import excel using "$path_dropbox/03_sampling/Output/Indiv_List_15 Mar 2021.xlsx", clear first
	
	keep HHID 
	
	tempfile selected 
	sa 		`selected'
	
restore 

merge 1:1 HHID using `selected'

* Drop respondents selected
drop if _merge == 3 

* Draw random number
sort HHID, stable 
gen rand = runiform()


* Export list 
bys Village: egen rank_replacement = rank(rand)

sort Village rank_replacement 

drop if rank_replacement > 5 

drop rand _merge 

rename rank_replacement Ordre_Remplacement

export excel using "$path_dropbox/03_sampling/Output/ThimoR_Replacement_`date'.xlsx", replace firstrow(var)



