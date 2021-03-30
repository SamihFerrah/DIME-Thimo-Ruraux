********************************************************************************
********************************************************************************
					* MASTER DO-FILE THIMOR PROJECT   *
********************************************************************************
********************************************************************************


********************************************************************************
********************************************************************************
/*

Author : Samih Ferrah, samih.ferrah@gmail.com / sferrah@worldbank.org
Date : 24th March 2021


*/

********************************************************************************
********************************************************************************
* 0. INSTALL ADDITIONAL COMMAND USED IN CLEANING 
********************************************************************************
********************************************************************************
	local install	0

if `install' {					// I ADDED A SWITCH HERE SO PACKAGES ARE NOT INSTALLED IF NOT NEEDED
	cap ssc install strip
	cap ssc install dups
	cap ssc install eststo 
	cap ssc install ietoolkit 
	cap ssc install fs
}
********************************************************************************
********************************************************************************
* 1. DEFINE USERS GLOBAL AND PATH
********************************************************************************
********************************************************************************
pause on
clear all
set more off
ieboilstart, version(15.0)


	*global user "samih"
	*global user "Christelle"
	*global user "Issa"
	*global user "NEWUSER"
	

if "$user" =="samih"{
	global path          "C:/Users/wb553190/OneDrive - WBG/Documents/GitHub/DIME-Thimo-Ruraux"
	global path_dropbox  "C:/Users/wb553190/Dropbox/World Bank/Code Peer Review 2021/ThimoR"
}

if "$user" =="Christelle"{

}
	
if "$user" == "Issa"{
		
}

// New user complete below path \\

if c(username) =="Timo Kapelari"{			// 	THIS LINE HELPS YOU SAVE ONE MANUAL STEP BY AUTOMATICALLY SELECTING THE RIGHT USER
	global path          "C:/Users/Timo Kapelari/Documents/GitHub/DIME-Thimo-Ruraux" 						// Path to github repository aka zip folder called mafita_repo_codereview
	global path_dropbox  "C:/Users/Timo Kapelari/Dropbox/Code Peer Review 2021/ThimoR"							// Path to de-identified data (customized for the code-review)
}

********************************************************************************
********************************************************************************
* 2. DEFINE PATH TO DIFFERENT DROPBOX AND GUTHUB FOLDER
********************************************************************************
********************************************************************************
global data_root 	"$path_dropbox/Encrypted Data"
global root 		"$path_dropbox/Stata"

********************************************************************************
********************************************************************************
* 3. RUN ADO FILE FOR USER WRTITTEN COMMAND 
********************************************************************************
********************************************************************************


********************************************************************************
********************************************************************************
* 4. GLOBAL TO ACTIVATE IMPORT AND CLEANING OF RAW DATA
********************************************************************************
********************************************************************************

	************************************
	* Randomization
	************************************
	// I would code witches with locals unless they are needed in another do file.
	// This would be a clenar way of coding following Stata best practices
	
	
global rand_village    = 1														// TURN ON TO RANDOMLY SELECT VILLAGES FOR THIMO RURAX INTERVENTION
global rand_individual = 1														// TURN ON TO RANDOMLY SELECT INDIVIDUAL FOR THIMO RURAUX INTERVENTION

	***********************************
	* CLEANING
	***********************************
	

	**********************************
	* CONSTRUCTION
	**********************************
	

********************************************************************************
********************************************************************************
* 5. DO-FILE BEING ACTIVATED BY GLOBAL ABOVE
********************************************************************************
********************************************************************************

if $rand_village ==1{
	do "$path/dofiles/Randomization/02_ThimoR_Randomisation_Villages.do"
}

if $rand_individual ==1{
	do "$path/dofiles/Randomization/03_ThimoR_Randomization_HH.do"
}



