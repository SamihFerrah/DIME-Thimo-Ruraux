
********************************************************************************
********************************************************************************
*					SELECTION RESPONDENTS TO BE BACKCHECKED
********************************************************************************
********************************************************************************
	clear all
	gl ROOT 	       "C:\Users\chmakoug\Dropbox\WB_DRC_Eastern_Recovery\13_endline\02_Thimor\"
	gl BCINDV	       "${ROOT}03_Sampling\Output\"
	gl BCVILLAGE       "${ROOT}07_Data (prestest, pilote, end)\Data of field\raw\"

	set seed 04262021


   import excel "$BCINDV/Indiv_List_15 Mar 2021.xlsx", sheet("Sheet1") firstrow clear
   *rename var to alow merge with 
	rename Province a1_province 
	rename Territoire a1_territory 
	rename Village a1_village
	rename HHID hhid
	
		
	*total number of respondent to be surveyed by territory
	gen       eff_ind = 1 
	bys		  a1_province a1_territory: egen tot_todo=count(eff_ind)
	
	*Here we will compute the 5% of respondents to be surveyed(according to the ToR)
	gen       target_respondent = tot_todo*0.05 	
	replace   target_respondent = round(target_respondent,1)
	
	sa "$BCINDV/Indiv_List", replace
	
	
	*****
	*Main sample 
	*****
	u "$BCINDV/Indiv_List", clear

	sort	hhid, stable 
	bys 	a1_province a1_territory: g rand = runiform()							// Draw random number 
	bys 	a1_province a1_territory: egen rank_select = rank(rand)					// Create rank variable 
	
	* Select 5% of respondants in each territory 	

	gen 	 selected_backcheck = 0 

	levelsof a1_territory, local(territory_select)
	
	foreach  place of local territory_select{
	
	replace  selected_backcheck = 1 if rank_select <= target_respondent 
	
	}	
	
	keep if selected_backcheck==1
       
	keep a1_province a1_territory Corridor a1_village hhid Noms target_respondent
	
	
	sort  a1_province a1_territory Corridor a1_village, stable
	tempfile sample1 
	sa      `sample1', replace
export   excel using list_backcheck, sheet("mainlist_backcheck") sheetreplace firstrow(var) 
export   excel using list_backcheck, sheet("list1_backcheck") sheetreplace firstrow(var) 


    merge 1:1  a1_province a1_territory Corridor a1_village hhid using "$BCINDV/Indiv_List.dta" , keep(2)    //merge with the main list of indidivu
	drop _merge
	tempfile data_rest1 
	sa     `data_rest1', replace 
	
	
	
	*****
	*second sample to be use for replacement
	*****
	
	 sort	hhid, stable 
	bys 	a1_province a1_territory: g rand = runiform()							//Draw random number
	bys 	a1_province a1_territory: egen rank_select = rank(rand)					// Create rank variable 
	
	* Select 5% in each territory 	

	gen 	 selected_backcheck = 0 

	levelsof a1_territory, local(territory_select)
	
	foreach  place of local territory_select{
	
	replace  selected_backcheck = 1 if rank_select <= target_respondent 
	
	}	
	
	keep if selected_backcheck==1
       
	keep a1_province a1_territory Corridor a1_village hhid Noms target_respondent
	
	
	sort a1_province a1_territory Corridor a1_village, stable
	tempfile sample2 
	sa      `sample2', replace
	export   excel using list_backcheck, sheet("list2_backcheck") sheetreplace firstrow(var) 


	merge 1:1  a1_province a1_territory Corridor a1_village hhid using "`data_rest1'" , keep(2)    //merge with the main list of indidivu
	drop _merge
	
	
	
	*****
	*Third sample to be use for replacement
	*****
	
	sort 	hhid, stable 
	bys 	a1_province a1_territory: g rand = runiform()							//Draw random number
	bys 	a1_province a1_territory: egen rank_select = rank(rand)					// Create rank variable 
	
	* Select 5% in each territory 	

	gen 	 selected_backcheck = 0 

	levelsof a1_territory, local(territory_select)
	
	foreach  place of local territory_select{
	
	replace  selected_backcheck = 1 if rank_select <= target_respondent 
	
	}	
	
	keep if selected_backcheck==1
       
	keep a1_province a1_territory Corridor a1_village hhid Noms target_respondent
	sort a1_province a1_territory Corridor a1_village, stable
	export   excel using list_backcheck, sheet("list3_backcheck") sheetreplace firstrow(var) 

	tempfile sample3 
	sa      `sample3', replace 
 
	 
	 
	 
	 
********************************************************************************
********************************************************************************
*					FLAG VILLAGES WITH A 30% COMPLETION RATE
********************************************************************************
********************************************************************************


	// Create an indicator that flag villages completed 

	***********
	*selection done on O4/29/2021
	***********
	
	u "$BCINDV/Indiv_List", clear
	*total number of respondents to be surveyed by village
	gen       eff_village = 1 
	bys		  a1_province a1_territory a1_village: egen totindiv_todo=count(eff_village)
	keep 	  a1_province a1_territory Corridor a1_village   target_respondent totindiv_todo
	merge     1:1 a1_province a1_territory  a1_village   using "$BCVILLAGE/endline_ThimoR.dta"	//merge with data already collected
	
	*total number of respondents already surveyed
	bys   a1_province a1_territory a1_village: egen totindiv_done=count(eff_village)          ///
	         if  _merge==3																	
	
	*Create indicator for backcheck (indic_bc)
	replace totindiv_done=0 if totindiv_done==.
	gen     indic_bce=totindiv_done/totindiv_todo
	gen     village_bce=1 if indic_bce>=0.3  									//Village wille be backcheck when 30% of respondent is surveyed
	keep 	if village_bce==1
	
		
	tempfile bcvillage_done
	sa       `bcvillage_done', replace
	keep a1_province a1_territory Corridor a1_village hhid Noms ///
		   submissiondate supervisorname a1_enumname  
		 
	sort a1_province a1_territory Corridor a1_village, stable
	merge 1:1  a1_province a1_territory Corridor a1_village hhid using "`sample1'"	, keep(3)    //merge with data already collected
	drop _merge
	
	*exporting .CSV for preload
	rename  a1_enumname Enumerator
	rename  hhid HHID
	rename  submissiondate Date
	rename  a1_province Province
	rename  a1_territory Territoire
	rename  a1_village Village

	keep Province Territoire Corridor Village Date Enumerator HHID 
	export  excel   ///
			using "$ROOT/04_Survey Material (Questionnaires, formulaires and others)\thimor_backcheck", ///
			sheet("thimor_backcheck") sheetreplace firstrow(var) 

 