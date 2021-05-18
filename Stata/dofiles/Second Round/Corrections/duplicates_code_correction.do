********************************************************************************
********************************************************************************
* 					DUPLICATES IN CODE CORRECTION
********************************************************************************
********************************************************************************

	* Add correction or drop survey to resolve for duplicates based on Field coordinator's comment from field

	clear all
	gl ROOT 	       	"C:\Users\chmakoug\Dropbox\WB_DRC_Eastern_Recovery\13_endline\02_Thimor\"
	gl DATAI         	"${ROOT}07_Data (prestest, pilote, end)\Data of field\raw\"
	gl DATAF	      	"${ROOT}07_Data (prestest, pilote, end)\Data of field\clean\"
	gl BCINDV	       	"${ROOT}03_Sampling\Output\"
	

	*Added 28th April
	u "$DATAI/ThimoR_Individual_Encrypted.dta", clear
	
	
	*search for duplicate
	bys  hhid: gen doublon=_n													    
	ta 	 doublon																	
	drop doublon
	
	*Correction of duplicate found and Replace the false hhid with the correct one
	gen     HHID=hhid
	replace hhid ="420023" if hhid =="10015"  & key=="uuid:68094395-3685-4f38-8693-6d4e19babff4"  
	replace HHID = "420023" if key=="uuid:68094395-3685-4f38-8693-6d4e19babff4"
	tempfile thimor
	
	
	*Correction au 12 Mai
	replace hhid ="180036" if hhid ==""  & key==""  
	replace HHID = "180036" if key==""

	replace hhid ="180036" if hhid ==""  & key==""  
	replace HHID = "180036" if key==""
	
	replace hhid ="180036" if hhid ==""  & key==""  
	replace HHID = "180036" if key==""
	
	replace hhid ="180036" if hhid ==""  & key==""  
	replace HHID = "180036" if key==""
	
	replace hhid ="180036" if hhid ==""  & key==""  
	replace HHID = "180036" if key==""
	
	replace hhid ="180036" if hhid ==""  & key==""  
	replace HHID = "180036" if key==""
	
	replace hhid ="180036" if hhid ==""  & key==""  
	replace HHID = "180036" if key==""
	
	replace hhid ="180036" if hhid ==""  & key==""  
	replace HHID = "180036" if key==""






/*
180036	FAIDA BAZUZI ODILE	uuid:2a2a11c7-383e-4330-97dd-422302e5cc36
180036	FAIDA BAZUZI ODILE	uuid:9ee7d444-de20-47d2-9db7-14be0032b17d

210065	MAPYA MSENGA AARON	uuid:e4c5f6a2-7c90-473e-b32c-046b5fcf20ab
210065	NALANDA MUZUSANGABO DESTIN	uuid:04466f1a-a62a-463f-85d3-fb3dff3e4ef9

*supprimer l'enquête du 06
2790096	MOSOMBO NGABULA Tr�sor	uuid:e7eb234a-8ae3-4abc-bbb9-5e815fdb8e98
2790096	HERI KISHEKU ERIC	uuid:ab5703c8-d1ac-47ce-8827-20dc87052e71

*Une enquête à supprimer l'enquête du 06 
3050014	OMBENI KABALI Mo�se	uuid:2fa8dda4-ca53-4b8e-a23c-02b97e519fff
3050014	BOUWE  BOFUTCHA JUNIOR	uuid:0613774a-ba7b-46d7-85f6-9edabf41b101

*L'enquête à conserver est celle de SAFI MUDERHWA CHRISTELLE en attente de l'explication de David
320042	BISIMWA RUBANGUKA DAVID	uuid:e93ba343-cf29-4215-b1a6-b1c799e00186
320042	SAFI MUDERHWA CHRISTELLE	uuid:9fa86077-faea-44d0-abaa-58a26dd82ab4

*retenir l'enquête qui s'est déroulée à de 11h à 13h et en attente de celle faite à 16
630011	BAHIZIRE ISSA JEAN DE DIEU	uuid:972b68b8-4ea1-454e-b8b4-0f5c97e1690a
630011	BAHIZIRE ISSA JEAN DE DIEU	uuid:fd8bc8d4-bae5-4bff-9af5-951c81d94e1a

**retenir l'enquête qui s'est déroulée le 30 Avril à 9h  et en attente de celle du 29 Avril
660034	BAHIZIRE ISSA JEAN DE DIEU	uuid:bbb0e95b-8f97-4510-8634-8cd805ae07eb
660034	BAHIZIRE ISSA JEAN DE DIEU	uuid:231fb2bc-081d-458f-8737-8211158af2c8
*/
	
	/*
	sa `thimor', replace
	
	
	/*Appliquer obligatoirement la partie ci-dessousAù
	*A partir d'ici appliquer quand il faut corriger et obtenir la base finale 
	
	*data base of all individu to be surveyed
	 import excel "$BCINDV/Indiv_List_15 Mar 2021.xlsx", sheet("Sheet1") firstrow clear
	 merge 1:1 HHID using `thimor', keep(3)
	 
	 
	 replace 	a1_name=Noms if key=="uuid:68094395-3685-4f38-8693-6d4e19babff4"
	 destring	ages, replace
	 replace    ages=Age if key=="uuid:68094395-3685-4f38-8693-6d4e19babff4"
	 replace    a1_province=Province  
	 replace  	a1_territory=Territoire  
	 replace    a1_village=Village
	 drop       Province Territoire Village Noms Age ///
				Adresse Phone Reference_Nom Reference_Adresse Reference_Phone ///
				Selection Latitude Longitude


	*Après avoir exécuté ce do il faut exécuté le do du dayly cleanning


