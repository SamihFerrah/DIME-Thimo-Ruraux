********************************************************************************
********************************************************************************
* 					ERROR AND CORRECTION IN VARIABLES
********************************************************************************
********************************************************************************

* Add correction or drop survey with code error 

*correction sur un enregistrement sans hhid et sans age
*l'enquêteur nommé Joelle MARUNGA est le responsable de cette enregistrement et on ne comprend pas comment cela à été possible.
*A vérifier auprès de l'enquêteur
replace hhid="1950013" if key=="uuid:9b6d5afa-6a3b-4c87-a64c-5d2ea88b1857"
replace ages="58" if key=="uuid:9b6d5afa-6a3b-4c87-a64c-5d2ea88b1857"
replace adresses="JUPAVONE" if key=="uuid:9b6d5afa-6a3b-4c87-a64c-5d2ea88b1857" 
replace telephones =".c" if key=="uuid:9b6d5afa-6a3b-4c87-a64c-5d2ea88b1857"
replace personne_de_references ="UGEN AKELO" if key=="uuid:9b6d5afa-6a3b-4c87-a64c-5d2ea88b1857"
replace enrollmentdates="Septembre 2018" if key=="uuid:9b6d5afa-6a3b-4c87-a64c-5d2ea88b1857"  






