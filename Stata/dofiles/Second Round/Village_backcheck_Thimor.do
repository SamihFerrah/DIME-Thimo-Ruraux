
	 
********************************************************************************
********************************************************************************
* FLAG VILLAGES WITH A 30% COMPLETION RATE AND SELECT RESPONDENT TO BE BACKCHEK
********************************************************************************
********************************************************************************

*******
*Ce do file est à 1 fois par semaine (samedi) pour déterminer les village qui auront le backcheck
*******

	clear all
	gl ROOT 	       "C:\Users\chmakoug\Dropbox\WB_DRC_Eastern_Recovery\13_endline\02_Thimor\"
	gl DATAF	       "${ROOT}07_Data (prestest, pilote, end)\Data of field\clean\"
	gl DATAI           "${ROOT}07_Data (prestest, pilote, end)\Data of field\raw\"
	gl BCINDV	       "${ROOT}03_Sampling\Output\"
	gl git_Thimor       "C:\Users\chmakoug\Dropbox\Mon PC (iutclens67)\Desktop\HFC\Repo\DIME-Thimo-Ruraux\Stata\"

	set seed 04262021

	// Create an indicator that flag villages completed 

	***********
	*selection done on O4/29/2021
	***********
	
	*u "$BCINDV/Indiv_List", clear
	
	
	import excel "$BCINDV/Indiv_List_15 Mar 2021.xlsx", sheet("Sheet1") firstrow clear
   *rename var to alow merge with 
	rename Province a1_province 
	rename Territoire a1_territory 
	rename Village a1_village
	rename HHID hhid

	*total number of respondents to be surveyed by village
	gen       eff_village = 1 
	bys		  a1_province a1_territory a1_village: egen totindiv_todo=count(eff_village)
	keep 	  a1_province a1_territory Corridor a1_village  totindiv_todo hhid 
	merge     1:1 a1_province a1_territory a1_village  hhid  using "$DATAF/ThimoR_Individual_clean.dta"	//merge with data already collected

	
	*total number of respondents already surveyed by village
	gen 	eff_village=1
	bys   	a1_province a1_territory a1_village: egen totindiv_done=count(eff_village) if  _merge==3	
	drop 	_merge

	
	*Create indicator for backcheck (indic_bc)
	replace totindiv_done=0 if totindiv_done==.
	gen     indic_bce=totindiv_done/totindiv_todo
	gen     village_bce=1 if indic_bce>=0.3  									//Village will be backcheck when 30% of respondent is surveyed
	

	
	keep 	if village_bce==1
	keep 	indic_bce totindiv_todo totindiv_done a1_province a1_territory ///
			Corridor a1_village hhid a1_date a1_timeinterview a1_teamid ///
			supervisorname a1_enumname a1_name
	

	*keep only village with 30% of respondent or more 
	collapse (first)indic_bce totindiv_todo totindiv_done, ///
			by(a1_province a1_territory Corridor a1_village)  
	
	*select 50% of village
	set seed 04262021
	sample 50, by(a1_province a1_territory)
		

	tempfile village_bc
	sa 		`village_bc'														//village where 30% or more respondents have been survey 	
	
	u "$DATAF/ThimoR_Individual_clean.dta",  clear
	merge        m:1 a1_province a1_territory Corridor a1_village  ///
		             using `village_bc'					 , keep(3)									//merge with data already collected
	drop 		_merge
	
	*select 5% of respondent to be backcheck
	set seed 04262021
	sample 10
	
	*rename data to enable export
	rename a1_province Province
	rename a1_territory Territoire 
	rename a1_village Village
	rename a1_date Date
	rename a1_enumname  Enumerator
	rename a1_name nom
	rename a1_teamid equipe
	rename supervisorname superviseur
	
	sort Province Territoire Corridor Village, stable 
	
	*export data to send to IHfRA
	export excel Province Territoire Corridor Village HHID Date Enumerator nom equipe superviseur ///
			using "${ROOT}/04_Survey Material (Questionnaires, formulaires and others)\thimor_backcheck.xls", replace firstrow(var)

	*Export csv for preload 
	 export delimited Province Territoire Corridor Village HHID Date Enumerator nom equipe superviseur ///
	 using "${ROOT}/04_Survey Material (Questionnaires, formulaires and others)\thimor_backcheck.csv", replace


	
/*
	*On a un total de 260 Villages pour toutes l'enquête
	*On a un total de 139 village en appliquant 5% de personnes à Backcheker on 
	*Actuellement on a 29 Villages qui on >30% de repondants (01 Mai 2021)
	*13 villages non sont pas éligible backchek dans ces 29
	*Sur les 16 villages éligibles on a 20 personnes à enquêter
	 			
		