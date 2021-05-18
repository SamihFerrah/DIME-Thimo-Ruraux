
	 
********************************************************************************
********************************************************************************
*					Travail sur les remplacements
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
	
	*On cherche à rajouter la selection à la liste des personnes décédées
	*import de la liste des personnes décédées
	import excel "${ROOT}/01_Admin_Interaction with INfRA and FSRDC\Suivi des activités avec IHfRA\Replacement_inprogress.xlsx", ///
	       sheet("decedees") firstrow clear
	drop 	Age
	tempfile remplacement
	sa       `remplacement'

	
	
	import excel "$BCINDV/Indiv_List_15 Mar 2021.xlsx", sheet("Sheet1") firstrow clear
	merge 1:1 Province Territoire Corridor Village HHID Noms Gender  using `remplacement', keep(3)
	drop _merge
	sort Province Territoire Village Noms Selection HHID Corridor, stable
	
	
	
	
	
	