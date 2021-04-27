********************************************************************************
********************************************************************************
*				THIMO RURAUX CLEANING 						   *
********************************************************************************
********************************************************************************
local date = c(current_date)




gl ROOT 	  "C:\Users\chmakoug\Dropbox\WB_DRC_Eastern_Recovery\13_endline\02_Thimor\"
gl INPUT	  "${ROOT}07_Data (prestest, pilote, end)\Data of field\raw\"
gl git_Thimor "C:\Users\chmakoug\Dropbox\Mon PC (iutclens67)\Desktop\HFC\Repo\DIME-Thimo-Ruraux\Stata\"
*gl OUTPUT 	"${ROOT}output\"


	
********************************************************************************
********************************************************************************
* 1) CHECK THAT ALL SURVEY SUBMITTED ARE COMPLETED 
********************************************************************************
********************************************************************************

u "$INPUT/ThimoR_Individual_Encrypted.dta", clear 

/* 	Define indicator for survey completeness, often the last variables mandatory
	for all respondent not being missing
*/

* Generate indicator for completed survey 

g 		tot_complete = 0 
replace tot_complete = 1 if i3_personcontribut!=. 
														

cap format submissiondate  %tcDDmonCCYY
if _rc == 0{
    
	gen date = dofc(submissiondate) 
	
	format date %td

}
else{
    
	split submissiondate,parse(" ") g(date_tmp)
	
	g 		date_tmp12 = date_tmp1 if date_tmp2 == "déc."
	
	replace date_tmp12 = date_tmp1 if date_tmp2 =="févr."
	replace date_tmp12 = date_tmp1 if date_tmp2 =="janv."
	replace date_tmp1 = "Dec" if date_tmp2 =="déc."
	replace date_tmp1 = "Feb" if date_tmp2 =="févr."
	replace date_tmp1 = "Jan" if date_tmp2 =="janv."
	replace date_tmp2 = date_tmp12 +"," if date_tmp2 == "déc." 
	replace date_tmp2 = date_tmp12 +"," if date_tmp2 == "févr." 
	replace date_tmp2 = date_tmp12 +"," if date_tmp2 == "janv." 
	
	drop date_tmp12 
	
	replace submissiondate = date_tmp1+" "+date_tmp2 +date_tmp3 

	cap drop date_tmp* month_tmp day_tmp	
	
	rename submissiondate today_char
	
	gen today=date(today_char,"MDY",2017)
	
	format today %td
	
	label variable today "Date of interview"
}


********************************************************************************
********************************************************************************
* 3) APPLY CORRECTIONS FOR DUPLICATES OR ERROR IN CODE 
********************************************************************************
********************************************************************************
/* 	Run correction do-files in which we apply the different correction to keep this
	one clean from thousands line of correction
*/

do "$git_Thimor\dofiles\Second round\Corrections\duplicates_code_correction.do"
do "$git_Thimor\dofiles\Second round\Corrections\error_code_correction.do"



********************************************************************************
********************************************************************************
* 5) RECODE AND LABEL MISSING VARIABLES
********************************************************************************
********************************************************************************
/* 	Recode and label missing variables with special character based 
	on respondent answers (DK, RFS)
*/

	* Recode missing value with specical character 
	
foreach var of varlist _all { 													//loop over all variables
	capture confirm numeric variable `var' 										//check that a variable is numeric
		if !_rc{
			cap noi replace `var' =.k if `var'== -999 | `var' == -99 | `var' == -9		   //don't know
			cap noi replace `var' =.w if `var'== -998 | `var' == -98 | `var' == -8 		  //not relevant 
			cap noi replace `var' =.z if `var'== -997 | `var' == -97 | `var' == -7 		 //refuse to say
			cap noi replace `var' =.o if `var'==  99                           		    // other exception

		}
}



save "$INPUT/endline_ThimoR.dta", replace 

/*
********************************************************************************
********************************************************************************
* 4) CHECK THAT WE HAVE ALL THE DATA OF THE DAY 
********************************************************************************
********************************************************************************
/* 	Test that all data from the field is on the server: match survey data logs from the
	field with survey data logs on the server to confirm that all the data from the 
	field has been transferred to the server. 
*/

preserve 

	* Import daily report 
	
import excel "C:\Users\chmakoug\Dropbox\WB_DRC_Eastern_Recovery\13_endline\02_Thimor\01_Admin_Interaction with INfRA and FSRDC\Suivi des activités avec IHfRA\Update_ThimoR 20210405.xlsx", sheet("Update_Thimo") firstrow clear	
	replace Status = "1" if Status =="Anciens codes 33"
	
	cap confirm numeric variable Status

	if _rc !=0{
		
		replace Status = subinstr(Status," ","",.)
		
	}
	
	destring Status, replace 
	
	* Keep last days of data collection 
	keep if Status == 1	| Status == 33 | Status == 99							// Keep completed survey
	
	tab HHID if Status == 33 
	
	rename HHID 	hhid
	rename Status 	Etat
	rename Date 	Date_complete
	
	keep hhid Etat Date_complete Nom
	
	* Create temperoray file 
	tempfile daily_completion
	sa   	`daily_completion'
	
restore

cap drop _merge 

* Merge data with completion report 
merge m:1 hhid using `daily_completion'

* Create indicator for missing survey
g 		missing_survey = 0 
replace missing_survey = 1 if _merge == 2 

label var missing_survey "Missing survey"

* Create indicator for survey outside of report
g 		outside_report = 0
replace outside_report = 1 if _merge == 1 & tot_complete == 1 

label var outside_report "Absent from report"

* Export results for BJKA 

preserve 
	
	* Keep instances with issues 
	keep if missing_survey == 1 | outside_report == 1 | tot_complete == 0 
	
	* Code to string 
	g 		description = "Absent de la base mais signale comme complete" 		if missing_survey == 1
	replace description = "Dans la base mais pas dans le rapport "				if outside_report == 1 
	replace description = "Sondage incomplet" 									if tot_complete == 0 
	
	rename a1_date 		Date_Sondage
	rename description 	Description
	
	keep hhid Description Date_Sondage Date_complete
	
	order Date_Sondage Date_complete hhid Description
	
	sort Date_Sondage Description
	* Export to excel
	
	export excel using "$shared/Daily Report/Update BJKA.xlsx", sheet("Probleme Completion", replace) first(var)
	
restore 
	
drop if _merge == 2 

cap drop _merge 

********************************************************************************
********************************************************************************
* 5) ERROR IN CODE
********************************************************************************
********************************************************************************

/*	Test for error in code: Use the original assignement list to compare original code and 
							and code enter by the enumerator
*/

* Merge and check that code correspond to the original assignment
cap drop _merge 

cap destring Age Telephone1 Telephone2, replace 

merge m:1 HHID using "A:/Assignment/Full Sample.dta", gen(code_check) keep(1 3) keepusing(HHID)

g 		error_code = 0 
replace error_code = 1 if code_check ==1
											// If code only in master then error in code

drop code_check 

count if error_code ==1 

if `r(N)' > 0 {

	preserve 
		
		keep if error_code == 1 
		 
		sort today today  
		 
		keep 	HHID a1_date a1_enumerator Nom 
		order 	HHID a1_date a1_enumerator Nom 
		
		rename 	(HHID a1_date a1_enumerator Nom ) ///
				(Faux_Code Date Enqueteur Nom)
				
		export excel using "$shared/Data Cleaning/Cleaning_Issue_Tunisia_Entrepreneurship.xlsx", sheet("Error Code", replace) first(var)
		
	restore
}

********************************************************************************
********************************************************************************
* 6) DUPLICATE TEST
********************************************************************************
********************************************************************************
/*	Test for duplicates: since SurveyCTO/ODK data provides a number of duplicates, 
	check for duplicates using ieduplicates.
*/

* Drop perfect duplicates 

duplicates drop 

* Duplicates in code among interviews

duplicates tag HHID if tot_complete == 1 & error_code == 0, g(dup)				// Check for duplicates among completed survey

preserve

keep if dup > 0 & dup !=.

keep hhid a1_enumerator Nom a1_respondentname a1_respondentname_corr a1_date 
sort hhid 
order hhid a1_enumerator Nom a1_respondentname a1_respondentname_corr a1_date

	export excel using "$shared/Data Cleaning/Cleaning_Issue_Tunisia_Entrepreneurship.xlsx", sheet("Duplicates Code", replace) first(var)

restore

* Duplicates in name ?


* Destring data 
destring _all, replace 

do "$git_tunisia/dofiles/Second round/Construct/label_variables.do"


********************************************************************************
********************************************************************************
* 7) Add common ID_HH (= HOUSEHOLD ID) for partner and cash grants participant
********************************************************************************

* Import HH ID (for cash grant and partner)

preserve 

	import excel using "$home/14. Female Entrepreneurship Add on/Data/General/ID Cash HH.xlsx", clear first
	
	tempfile ID_HHH
	sa 	    `ID_HHH'
	
restore 

cap drop _merge 

merge m:1 HHID using `ID_HHH', update

drop _merge

* Create dummie variable to flag respondent for which we survey both 
* female and male partner_only

duplicates tag ID_HH if ID_HH !=. & tot_complete == 1, g(participant_partner)

label var participant_partner "Duo: participant x partner"

********************************************************************************
********************************************************************************
* 8) DROP USELESS VARIABLES (Duration notes calculates)
********************************************************************************
********************************************************************************
/* 	Drop variables that only make sense for questionnaire review (duration, notes,
	calculates)
*/

* Add to local below useless variable 

local var_to_drop ""
					
foreach var of local var_to_drop{

	cap drop `var'
	
}
		 
drop Status 

********************************************************************************
********************************************************************************
* 9) Prepare outcomes by recoding variables
********************************************************************************
********************************************************************************

do "$git_tunisia/dofiles/Second round/Construct/recodedirection.do"


********************************************************************************
********************************************************************************
* 11) Create Attrition indicator
********************************************************************************
********************************************************************************

do "$git_tunisia/dofiles/Second round/Construct/Attrition Indicator.do"



********************************************************************************
********************************************************************************
* 10) Save temporary data with PII
********************************************************************************
********************************************************************************

sa "$vera/temp/clean_CashXFollow_PII_2.dta", replace 


********************************************************************************
********************************************************************************
* 12) Merge Baseline and Endline
********************************************************************************
********************************************************************************


do "$git_tunisia/dofiles/Second round/Construct/Merge Baseline Endline.do"

********************************************************************************
********************************************************************************
* 13) SAVE clean data  with PII
********************************************************************************
********************************************************************************

destring Strata, replace 

* Save data with PII 

sa "$vera/clean/clean_CashXFollow_PII.dta", replace 

********************************************************************************
* 14) DE-IDENTIFY DATA 
********************************************************************************
********************************************************************************

* 1) Define variable to be drop (Add variable below to be dropped)

local deidentification 	"username calc_name complete_name a1_respondentname confirm_name a1_respondentname_corr Nom Father devicephonenum Telephone1 Telephone2"


* 2) Drop ID variable 

foreach var of local deidentification {
	
	capture noisily drop `var' 													

}

sa "$home/14. Female Entrepreneurship Add on/Data/Second Round/cleandata/clean_CashXFollow_noPII.dta", replace

*/

********************************************************************************
********************************************************************************
*					SELECT RESPONDENT TO BE BACKCHECKED
********************************************************************************
********************************************************************************
set seed 04262021

* Flag villages with a 30% completion rate

	// Create an indicator that flag villages completed 

   import excel "C:\Users\chmakoug\Dropbox\WB_DRC_Eastern_Recovery\13_endline\02_Thimor\01_Admin_Interaction with INfRA and FSRDC\Suivi des activités avec IHfRA\Update_ThimoR 20210405.xlsx", sheet("Update_Thimo") firstrow clear
	
	*rename var to alow merge
	
	keep   HHID Status Province Territoire Corridor Village
	rename Province a1_province 
	rename Territoire a1_territory 
	rename Village a1_village
	rename HHID hhid
	
	*total number of respondent to be surveyed by village
	gen       eff_village = 1 
	bys		  a1_province a1_territory a1_village: egen tot_todo=count(eff_village)
	merge 1:1 hhid a1_province a1_territory a1_village using "$INPUT/endline_ThimoR.dta"	//merge with data already collected
	
	*total number of respondent already surveyed
	bysort   a1_province a1_territory a1_village: egen tot_done=count(eff_village)          ///
	         if  _merge==3																	
	
	*Create indicator for backcheck (indic_bc)
	replace tot_done=0 if tot_done==.
	gen     indic_bce=tot_done/tot_todo
	gen     village_bce=1 if indic_bce>=0.3  									//Village wille be backcheck when 30% of respondent is surveyed
	
	
	
	*Here we will compute the 5% of respondent to be surveyed (according to the ToR)
	gen target_respondent = tot_todo*0.05 
	
	replace target_respondent = round(target_respondent,1)
		
	levelsof a1_village, local(village_target)


	
	foreach place of local village_target{
		preserve
		keep if a1_village=="`place'"
		local target_`place' = target_respondent if a1_village == "`place'"	                        // Here we store in local the precise number of respondent to be surveyed in each villages given their sizes 
		restore
	}
	
	

	tempfile total 
	sa      `total'
	
	* Draw random number (here no enumerator stratification as it might makes things complicated as we will only have 30% of the sample at this moment)

	sort 	hhid, stable 
	bys 	a1_village: g rand = runiform() if village_bce == 1						// flaged_completion being the variable created above to flag villages with at least 30% completion rate
	bys 	a1_village: egen rank_select = rank(rand)								// Create rank variable 


	* Select 5% in each villages 	

	gen selected_backcheck = 0 

	levelsof village, local(village_select)

	foreach place of local village_select{
	
	replace selected_backcheck = 1 if rank_select <= `target_`place''
	
}	
	Keep a1_province a1_territory Corridor a1_village a1_teamid supervisorname ///
	 a1_enumname hhid a1_name if selected_backcheck==1
	 
	 
***********************************************************************************************************************************************************
/*
u "C:\Users\chmakoug\Dropbox\WB_DRC_Eastern_Recovery\13_endline\02_Thimor\07_Data (prestest, pilote, end)\Data of field\ThimoR_Individual_Encrypted.dta", clear
*convert date variables

*variable temps à retraiter aussi 
*j_duract (foalt) j_datetimes j_duraction(foalt)

**********
* Create id for enumerator, supervisor, and backchecker
**********
 egen enumid=group(a1_teamid a1_enumname)
 egen supid=group(supervisorname)
 gen bcer=1
destring ages, replace
destring j_duract, replace float
destring j_duraction, replace float

    
	split submissiondate,parse(" ") g(date_tmp)
	
	g 		date_tmp12 = date_tmp1 if date_tmp2 == "déc."
	replace date_tmp12 = date_tmp1 if date_tmp2 =="févr."
	replace date_tmp12 = date_tmp1 if date_tmp2 =="janv."
	replace date_tmp12 = date_tmp1 if date_tmp2 =="avr."
	replace date_tmp1 = "Dec" if date_tmp2 =="déc."
	replace date_tmp1 = "Feb" if date_tmp2 =="févr."
	replace date_tmp1 = "Jan" if date_tmp2 =="janv."
	replace date_tmp1 = "Apr" if date_tmp2 =="avr."
	replace date_tmp2 = date_tmp12 +"," if date_tmp2 == "déc." 
	replace date_tmp2 = date_tmp12 +"," if date_tmp2 == "févr." 
	replace date_tmp2 = date_tmp12 +"," if date_tmp2 == "janv." 
		replace date_tmp2 = date_tmp12 +"," if date_tmp2 == "avr." 

	drop date_tmp12 
	
	replace submissiondate = date_tmp1+" "+date_tmp2+" "+date_tmp3+" "+date_tmp4 
	
	gen submissiondate1=clock(submissiondate,"MDYhms",2025)
    format %tc submissiondate1
	drop submissiondate
	rename submissiondate1 submissiondate 
	

*starttime 

	split starttime,parse(" ") g(date_tm)
	
	g 		date_tm12 = date_tm1 if date_tm2 == "déc."
	replace date_tm12 = date_tm1 if date_tm2 =="févr."
	replace date_tm12 = date_tm1 if date_tm2 =="janv."
	replace date_tm12 = date_tm1 if date_tm2 =="avr."
	replace date_tm1 = "Dec" if date_tm2 =="déc."
	replace date_tm1 = "Feb" if date_tm2 =="févr."
	replace date_tm1 = "Jan" if date_tm2 =="janv."
	replace date_tm1 = "Apr" if date_tm2 =="avr."
	replace date_tm2 = date_tm12 +"," if date_tm2 == "déc." 
	replace date_tm2 = date_tm12 +"," if date_tm2 == "févr." 
	replace date_tm2 = date_tm12 +"," if date_tm2 == "janv." 
		replace date_tm2 = date_tm12 +"," if date_tm2 == "avr." 

	drop date_tm12 
	
	replace starttime = date_tm1+" "+date_tm2+" "+date_tm3+" "+date_tm4 
	
	gen starttime1=clock(starttime,"MDYhms",2025)
    format %tc starttime1
	drop starttime
	rename starttime1 starttime 






*endtime	
	
		split endtime,parse(" ") g(date_t)
	
	g 		date_t12 = date_t1 if date_t2 == "déc."
	replace date_t12 = date_t1 if date_t2 =="févr."
	replace date_t12 = date_t1 if date_t2 =="janv."
	replace date_t12 = date_t1 if date_t2 =="avr."
	replace date_t1 = "Dec" if date_t2 =="déc."
	replace date_t1 = "Feb" if date_t2 =="févr."
	replace date_t1 = "Jan" if date_t2 =="janv."
	replace date_t1 = "Apr" if date_t2 =="avr."
	replace date_t2 = date_t12 +"," if date_t2 == "déc." 
	replace date_t2 = date_t12 +"," if date_t2 == "févr." 
	replace date_t2 = date_t12 +"," if date_t2 == "janv." 
		replace date_t2 = date_t12 +"," if date_t2 == "avr." 

	drop date_t12 
	
	replace endtime = date_t1+" "+date_t2+" "+date_t3+" "+date_t4 
	
	gen endtime1=clock(endtime,"MDYhms",2025)
    format %tc endtime1
	drop endtime
	rename endtime1 endtime 

	
	
	
save C:\Users\chmakoug\Dropbox\WB_DRC_Eastern_Recovery\13_endline\02_Thimor\11_hfc_thimor\05_data\02_survey\survey_data.dta, replace

*******************************************************************************************************************************************************



/*
********************************************************************************
********************************************************************************
*				THIMO RURAUX CLEANING 						   *
********************************************************************************
********************************************************************************
local date = c(current_date)


u "$vera/temp/temp_import_CashXFollow.dta", clear 

* Create special variable to merge 
 
g HHID = hhid 

merge m:1 HHID using "A:/Assignment/Full Sample.dta", keep(1 3) keepusing(Status Intervention trt_followup replacement Partenaire)

drop _merge 

g 		trt_cash = 0 if Intervention == "Cash Grants - Women"
replace trt_cash = 1 if Intervention == "Cash Grants - Women" & Status == "Treatment"

g 		trt_cash_0 = 0 if Intervention == "Cash Grants - Women"
replace trt_cash_0 = 1 if Intervention == "Cash Grants - Women" & Status == "Treatment" & Partenaire == "Non"

g 		trt_cash_1 = 0 if Intervention == "Cash Grants - Women"
replace trt_cash_1 = 1 if Intervention == "Cash Grants - Women" & Status == "Treatment" & Partenaire == "Oui"

* Imput to missing if treatment of other group

replace trt_cash_1 = . if trt_cash_0 == 1
replace trt_cash_0 = . if trt_cash_1 == 1

label var trt_cash	 "Cash Grant Treatment (Partenaire == 0)"
label var trt_cash_0 "Cash Grant Treatment (Partenaire == 0)"
label var trt_cash_1 "Cash Grant Treatment (Partenaire == 1)"
	
********************************************************************************
********************************************************************************
* 2) CHECK THAT ALL SURVEY SUBMITTED ARE COMLETED 
********************************************************************************
********************************************************************************


/* 	Define indicator for survey completeness, often the last variables mandatory
	for all respondent not being missing
*/

* Generate indicator for completed survey 

g 		tot_complete = 0 
replace tot_complete = 1 if trauma_cauchemars 	!=. & 	Intervention == "Cash Grants - Women" | ///
														Intervention == "Follow up - TCLP"
														
replace tot_complete = 1 if x9_109 				!=. & 	Intervention == "Cash Grants - Partenaire"

cap format submissiondate  %tcDDmonCCYY
if _rc == 0{
    
	gen date = dofc(submissiondate) 
	
	format date %td

}
else{
    
	split submissiondate,parse(" ") g(date_tmp)
	
	g 		date_tmp12 = date_tmp1 if date_tmp2 == "déc."
	
	replace date_tmp12 = date_tmp1 if date_tmp2 =="févr."
	replace date_tmp12 = date_tmp1 if date_tmp2 =="janv."
	replace date_tmp1 = "Dec" if date_tmp2 =="déc."
	replace date_tmp1 = "Feb" if date_tmp2 =="févr."
	replace date_tmp1 = "Jan" if date_tmp2 =="janv."
	replace date_tmp2 = date_tmp12 +"," if date_tmp2 == "déc." 
	replace date_tmp2 = date_tmp12 +"," if date_tmp2 == "févr." 
	replace date_tmp2 = date_tmp12 +"," if date_tmp2 == "janv." 
	
	drop date_tmp12 
	
	replace submissiondate = date_tmp1+" "+date_tmp2 +date_tmp3 

	cap drop date_tmp* month_tmp day_tmp	
	
	rename submissiondate today_char
	
	gen today=date(today_char,"MDY",2017)
	
	format today %td
	
	label variable today "Date of interview"
}


********************************************************************************
********************************************************************************
* 3) APPLY CORRECTIONS FOR DUPLICATES OR ERROR IN CODE 
********************************************************************************
********************************************************************************
/* 	Run correction do-files in which we apply the different correction to keep this
	one clean from thousands line of correction
*/

do "$git_tunisia/dofiles/Second round/Corrections/duplicates_code_correction.do"
do "$git_tunisia/dofiles/Second round/Corrections/error_code_tunisia.do"



********************************************************************************
********************************************************************************
* 5) RECODE AND LABEL MISSING VARIABLES
********************************************************************************
********************************************************************************
/* 	Recode and label missing variables with special character based 
	on respondent answers (DK, RFS)
*/

	* Recode missing value with specical character 
	
foreach var of varlist _all { 													//loop over all variables
	capture confirm numeric variable `var' 										//check that a variable is numeric
		if !_rc{
			cap noi replace `var' =.k if `var'== -999 | `var' == -99 | `var' == -9		//don't know
			cap noi replace `var' =.w if `var'== -998 | `var' == -98 | `var' == -8 		//refuse to say
			cap noi replace `var' =.z if `var'== -997 | `var' == -97 | `var' == -7 		//not relevant / other exception
		}
}

local partner_only x1_mgroles x1_mghome x1_mgkids x1_mgdecisions x1_mgrights1 x1_mgleader1 x1_mgleader2 	///
 x1_mgschlwork x1_mgill x1_mgopinion x1_mgpity x1_mgwork x1_mgedu x1_mgdomestic 		///
 x1_mgobey x1_mgspeak x1_mgcapacity x1_eduopp x1_boysfood x1_coupledu x1_leader3 		///
 x1_agreerole x1_mgrights2 x1_mgequality x1_mgfriends x1_mgfreetime_men 				///	
 x1_mg_freetime_women x1_mg_womenopi x1_mg_marry x1_participation x1_leader4			/// 
 x1_leader5 x1_leader6_1 x1_leader6_2 x1_leader6_3 x1_leader6_4 				///
 x1_leader6_5 x1_leader6_6 x1_leader6_7 x1_leader6_8 x1_leader6_9 x1_leader6_10 		///
 x1_leader7_1 x1_leader7_2 x1_leader7_3 x1_leader7_4 x1_leader7_5 			///
 x1_leader7_6 x1_leader7_7 x1_leader7_8 x1_leader7_9 x1_leader7_10 x1_leader9 			///
 x1_leader10 x1_participation2 x1_participation3 x2_hwviolenceintro x2_hwtolerate		///
 x2_goesout x2_refuseshave x2_burnsf x2_arguesshe x2_refusescook 			///
 x2_doesinfid x2_contraceptive x2_drinksalcohol x2_refusesclean x2_dowry			/// 
  x6_sxtalk x6_sxready x6_gay x6_friend x7_tough x7_insult 		///
 x8_pregn x8_contra x8_suggcontr x8_childresp x8_fatherchild x8_childdeci x8_contratype

 
foreach var of local partner_only {
	
	replace `var' = .a if Intervention != "Cash Grants - Partenaire"
	
}

********************************************************************************
********************************************************************************
* 4) CHECK THAT WE HAVE ALL THE DATA OF THE DAY 
********************************************************************************
********************************************************************************
/* 	Test that all data from the field is on the server: match survey data logs from the
	field with survey data logs on the server to confirm that all the data from the 
	field has been transferred to the server. 
*/

preserve 

	* Import daily report 
	
	import excel using "$shared/Daily Report/Update BJKA.xlsx", clear first 
	
	replace Status = "1" if Status =="Anciens codes 33"
	
	cap confirm numeric variable Status

	if _rc !=0{
		
		replace Status = subinstr(Status," ","",.)
		
	}
	
	destring Status, replace 
	
	* Keep last days of data collection 
	keep if Status == 1	| Status == 33 | Status == 99							// Keep completed survey
	
	tab HHID if Status == 33 
	
	rename HHID 	hhid
	rename Status 	Etat
	rename Date 	Date_complete
	
	keep hhid Etat Date_complete Nom
	
	* Create temperoray file 
	tempfile daily_completion
	sa   	`daily_completion'
	
restore

cap drop _merge 

* Merge data with completion report 
merge m:1 hhid using `daily_completion'

* Create indicator for missing survey
g 		missing_survey = 0 
replace missing_survey = 1 if _merge == 2 

label var missing_survey "Missing survey"

* Create indicator for survey outside of report
g 		outside_report = 0
replace outside_report = 1 if _merge == 1 & tot_complete == 1 

label var outside_report "Absent from report"

* Export results for BJKA 

preserve 
	
	* Keep instances with issues 
	keep if missing_survey == 1 | outside_report == 1 | tot_complete == 0 
	
	* Code to string 
	g 		description = "Absent de la base mais signale comme complete" 		if missing_survey == 1
	replace description = "Dans la base mais pas dans le rapport "				if outside_report == 1 
	replace description = "Sondage incomplet" 									if tot_complete == 0 
	
	rename a1_date 		Date_Sondage
	rename description 	Description
	
	keep hhid Description Date_Sondage Date_complete
	
	order Date_Sondage Date_complete hhid Description
	
	sort Date_Sondage Description
	* Export to excel
	
	export excel using "$shared/Daily Report/Update BJKA.xlsx", sheet("Probleme Completion", replace) first(var)
	
restore 
	
drop if _merge == 2 

cap drop _merge 

********************************************************************************
********************************************************************************
* 5) ERROR IN CODE
********************************************************************************
********************************************************************************

/*	Test for error in code: Use the original assignement list to compare original code and 
							and code enter by the enumerator
*/

* Merge and check that code correspond to the original assignment
cap drop _merge 

cap destring Age Telephone1 Telephone2, replace 

merge m:1 HHID using "A:/Assignment/Full Sample.dta", gen(code_check) keep(1 3) keepusing(HHID)

g 		error_code = 0 
replace error_code = 1 if code_check ==1
											// If code only in master then error in code

drop code_check 

count if error_code ==1 

if `r(N)' > 0 {

	preserve 
		
		keep if error_code == 1 
		 
		sort today today  
		 
		keep 	HHID a1_date a1_enumerator Nom 
		order 	HHID a1_date a1_enumerator Nom 
		
		rename 	(HHID a1_date a1_enumerator Nom ) ///
				(Faux_Code Date Enqueteur Nom)
				
		export excel using "$shared/Data Cleaning/Cleaning_Issue_Tunisia_Entrepreneurship.xlsx", sheet("Error Code", replace) first(var)
		
	restore
}

********************************************************************************
********************************************************************************
* 6) DUPLICATE TEST
********************************************************************************
********************************************************************************
/*	Test for duplicates: since SurveyCTO/ODK data provides a number of duplicates, 
	check for duplicates using ieduplicates.
*/

* Drop perfect duplicates 

duplicates drop 

* Duplicates in code among interviews

duplicates tag HHID if tot_complete == 1 & error_code == 0, g(dup)				// Check for duplicates among completed survey

preserve

keep if dup > 0 & dup !=.

keep hhid a1_enumerator Nom a1_respondentname a1_respondentname_corr a1_date 
sort hhid 
order hhid a1_enumerator Nom a1_respondentname a1_respondentname_corr a1_date

	export excel using "$shared/Data Cleaning/Cleaning_Issue_Tunisia_Entrepreneurship.xlsx", sheet("Duplicates Code", replace) first(var)

restore

* Duplicates in name ?


* Destring data 
destring _all, replace 

do "$git_tunisia/dofiles/Second round/Construct/label_variables.do"


********************************************************************************
********************************************************************************
* 7) Add common ID_HH (= HOUSEHOLD ID) for partner and cash grants participant
********************************************************************************

* Import HH ID (for cash grant and partner)

preserve 

	import excel using "$home/14. Female Entrepreneurship Add on/Data/General/ID Cash HH.xlsx", clear first
	
	tempfile ID_HHH
	sa 	    `ID_HHH'
	
restore 

cap drop _merge 

merge m:1 HHID using `ID_HHH', update

drop _merge

* Create dummie variable to flag respondent for which we survey both 
* female and male partner_only

duplicates tag ID_HH if ID_HH !=. & tot_complete == 1, g(participant_partner)

label var participant_partner "Duo: participant x partner"

********************************************************************************
********************************************************************************
* 8) DROP USELESS VARIABLES (Duration notes calculates)
********************************************************************************
********************************************************************************
/* 	Drop variables that only make sense for questionnaire review (duration, notes,
	calculates)
*/

* Add to local below useless variable 

local var_to_drop ""
					
foreach var of local var_to_drop{

	cap drop `var'
	
}
		 
drop Status 

********************************************************************************
********************************************************************************
* 9) Prepare outcomes by recoding variables
********************************************************************************
********************************************************************************

do "$git_tunisia/dofiles/Second round/Construct/recodedirection.do"


********************************************************************************
********************************************************************************
* 11) Create Attrition indicator
********************************************************************************
********************************************************************************

do "$git_tunisia/dofiles/Second round/Construct/Attrition Indicator.do"



********************************************************************************
********************************************************************************
* 10) Save temporary data with PII
********************************************************************************
********************************************************************************

sa "$vera/temp/clean_CashXFollow_PII_2.dta", replace 


********************************************************************************
********************************************************************************
* 12) Merge Baseline and Endline
********************************************************************************
********************************************************************************


do "$git_tunisia/dofiles/Second round/Construct/Merge Baseline Endline.do"

********************************************************************************
********************************************************************************
* 13) SAVE clean data  with PII
********************************************************************************
********************************************************************************

destring Strata, replace 

* Save data with PII 

sa "$vera/clean/clean_CashXFollow_PII.dta", replace 

********************************************************************************
* 14) DE-IDENTIFY DATA 
********************************************************************************
********************************************************************************

* 1) Define variable to be drop (Add variable below to be dropped)

local deidentification 	"username calc_name complete_name a1_respondentname confirm_name a1_respondentname_corr Nom Father devicephonenum Telephone1 Telephone2"


* 2) Drop ID variable 

foreach var of local deidentification {
	
	capture noisily drop `var' 													

}

sa "$home/14. Female Entrepreneurship Add on/Data/Second Round/cleandata/clean_CashXFollow_noPII.dta", replace




********************************************************************************
********************************************************************************
*					SELECT RESPONDENT TO BE BACKCHECKED
********************************************************************************
********************************************************************************
set seed 04262021

* Flag villages with a 30% completion rate

// Here christelle you need to create an indicator that flag villages completed 

import excel "C:\Users\chmakoug\Dropbox\WB_DRC_Eastern_Recovery\13_endline\02_Thimor\01_Admin_Interaction with INfRA and FSRDC\Suivi des activités avec IHfRA\Update_ThimoR 20210405.xlsx", sheet("Update_Thimo") firstrow clear
	
*	gen tot_village = 1 
bysort Province Territoire Corridor Village: egen 
	
	collapse (sum) tot_village, by(village)									// Collapsing at the village level will give you the total number of respondent to be surveyed 
	
	// Here we will also compute the 5% of respondent to be surveyed (according to the ToR)
	
	egen target = tot_village*0.05 
	
	replace target = round(target,1)
	
	levelsof village, local(village_target)
	
	foreach place of local village_target{
		
		local completion_target_`place' = target if village == "`place'"		// Here we store in local the precise number of respondent to be surveyed in each villages given their sizes 
		
	}
	
	tempfile total 
	sa      `total'
	
	u "endline data"
	
	keep village 
	
	gen count_village = 1 
	
	collapse (sum) count_village, by(village)									// Collapsing at the village level will give you the total number of respondent to be surveyed 
	
	merge 1:1 village using `total', keep(3)
	
	gen percent = count_village / tot_village 
	
	gen flaged_completion = 1 if percent >= 0.30
	
* Draw random number (@Christelle no enumerator stratification as it might makes things complicated as we will only have 30% of the sample at this moment)

sort HHID, stable 
by Village: g rand = runiform() if flaged_completion == 1						// flaged_completion being the variable created above to flag villages with at least 30% completion rate
bys Village: egen rank_select = rank(rand)										// Create rank variable 


* Select 5% in each villages 	

gen selected_backcheck = 0 

levelsof village, local(village_select)

foreach place of local village_select{
	
	replace selected_backcheck = 1 if rank_select <= `completion_target_`place''
	
}





















