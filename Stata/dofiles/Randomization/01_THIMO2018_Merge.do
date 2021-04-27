
	* DRC THIMO RURAUX TARGETING ANALYSIS
	* STEP PROJECT
	* This is the do file "appending" the 3 cleaned dataset of the EXANTE THIMO R program.
	* Author: Julie Bousquet and Guigonan Serge Adjognon
	* Research team: Eric, Chloe, Issa
	* Do file started: August 2017
	* Latest Update: May 2018
	********************************************************************************
global data "C:\Users\LENOVO\Dropbox\WB_DRC_Eastern_Recovery\18_Data\03. Component 2\Thimo Ruraux\ExAnte\03. Cleaning"

clear all

	import excel "$data\01. Dataset\01_raw\villagethimoruraux.xlsx", sheet("Feuil2") firstrow

	save "$data/01. Dataset/03_final/villagethimoruraux.dta", replace

clear all


	*******************************
	*IT DK KL *********************
	*******************************
	
	/*use 	"$data/01. Dataset/01_raw/THIMO2018_IT_BM_GA.dta", clear
		replace marital_status="1" if marital_status=="Marie/concubin"
		replace marital_status="2" if marital_status=="Divorce/separe"
		replace marital_status="3" if marital_status=="Veuve/veuf"
		replace marital_status="4" if marital_status=="Celibataire"
		replace marital_status="-7" if marital_status=="Refuse de repondre"
		replace marital_status="-8" if marital_status=="Non applicable"
		replace marital_status="-9" if marital_status=="Ne sait pas"
			destring marital_status, replace
		label def marital 1 "Marie/concubin" 2  "Divorce/separe" 3 "Veuve/veuf" 4 "Celibataire" -7 "Refuse de repondre" -8 "Non applicable" -9 "Ne sait pas"
		label values marital_status marital
		generate etatcivil=marital_status

	save "$data/01. Dataset/01_raw/THIMO2018_IT_BM_GA.dta", replace
	
	clear all
	use 	"$data/01. Dataset/01_raw/THIMO2018_IT_BM_LB.dta", clear
		replace etatcivil="1" if etatcivil=="Marie/concubin"
		replace etatcivil="2" if etatcivil=="Divorce/separe"
		replace etatcivil="3" if etatcivil=="Veuve/veuf"
		replace etatcivil="4" if etatcivil=="Celibataire"
		replace etatcivil="-7" if etatcivil=="Refuse de repondre"
		replace etatcivil="-8" if etatcivil=="Non applicable"
		replace etatcivil="-9" if etatcivil=="Ne sait pas"
			destring marital_status, replace
		label def marital 1 "Marie/concubin" 2  "Divorce/separe" 3 "Veuve/veuf" 4 "Celibataire" -7 "Refuse de repondre" -8 "Non applicable" -9 "Ne sait pas"
		label values etatcivil marital
		*generate etatcivil=marital_status
	save "$data/01. Dataset/01_raw/THIMO2018_IT_BM_LB.dta", replace


		clear all
	use 	"$data/01. Dataset/01_raw/THIMO2018_SK_MBH_UNOPS.dta", clear
		replace etatcivil="1" if etatcivil=="Marie/concubin"
		replace etatcivil="2" if etatcivil=="Divorce/separe"
		replace etatcivil="3" if etatcivil=="Veuve/veuf"
		replace etatcivil="4" if etatcivil=="Celibataire"
		replace etatcivil="-7" if etatcivil=="Refuse de repondre"
		replace etatcivil="-8" if etatcivil=="Non applicable"
		replace etatcivil="-9" if etatcivil=="Ne sait pas"
				destring etatcivil, replace
	label def marital 1 "Marie/concubin" 2  "Divorce/separe" 3 "Veuve/veuf" 4 "Celibataire" -7 "Refuse de repondre" -8 "Non applicable" -9 "Ne sait pas"
		label values etatcivil marital
		*generate etatcivil=marital_status
	save "$data/01. Dataset/01_raw/THIMO2018_SK_MBH_UNOPS.dta", replace
	
		clear all
	use 	"$data/01. Dataset/01_raw/THIMO2018_SK_WMK_B.dta", clear
		replace etatcivil="1" if etatcivil=="Marie/concubin"
		replace etatcivil="2" if etatcivil=="Divorce/separe"
		replace etatcivil="3" if etatcivil=="Veuve/veuf"
		replace etatcivil="4" if etatcivil=="Celibataire"
		replace etatcivil="-7" if etatcivil=="Refuse de repondre"
		replace etatcivil="-8" if etatcivil=="Non applicable"
		replace etatcivil="-9" if etatcivil=="Ne sait pas"
				destring etatcivil, replace
	label def marital 1 "Marie/concubin" 2  "Divorce/separe" 3 "Veuve/veuf" 4 "Celibataire" -7 "Refuse de repondre" -8 "Non applicable" -9 "Ne sait pas"
		label values etatcivil marital
	save "$data/01. Dataset/01_raw/THIMO2018_SK_WMK_B.dta", replace
	
	clear all
	use 	"$data/01. Dataset/01_raw/THIMO2018_IT_DF_DN.dta", clear
		replace marital_status="1" if marital_status=="Marie/concubin"
		replace marital_status="2" if marital_status=="Divorce/separe"
		replace marital_status="3" if marital_status=="Veuve/veuf"
		replace marital_status="4" if marital_status=="Celibataire"
		replace marital_status="-7" if marital_status=="Refuse de repondre"
		replace marital_status="-8" if marital_status=="Non applicable"
		replace marital_status="-9" if marital_status=="Ne sait pas"
				destring marital_status, replace
	label def marital 1 "Marie/concubin" 2  "Divorce/separe" 3 "Veuve/veuf" 4 "Celibataire" -7 "Refuse de repondre" -8 "Non applicable" -9 "Ne sait pas"
		label values marital_status marital
		generate etatcivil=marital_status
	save "$data/01. Dataset/01_raw/THIMO2018_IT_DF_DN.dta", replace
	
			clear all
	use 	"$data/01. Dataset/01_raw/THIMO2017_IT_DK_KL.dta", clear
			generate etatcivil=marital_status
		*replace etatcivil="1" if etatcivil=="Marie/concubin"
		*replace etatcivil="2" if etatcivil=="Divorce/separe"
		*replace etatcivil="3" if etatcivil=="Veuve/veuf"
		*replace etatcivil="4" if etatcivil=="Celibataire"
		*replace etatcivil="-7" if etatcivil=="Refuse de repondre"
		*replace etatcivil="-8" if etatcivil=="Non applicable"
		*replace etatcivil="-9" if etatcivil=="Ne sait pas"
				destring etatcivil, replace
	label def marital 1 "Marie/concubin" 2  "Divorce/separe" 3 "Veuve/veuf" 4 "Celibataire" -7 "Refuse de repondre" -8 "Non applicable" -9 "Ne sait pas"
		label values etatcivil marital
	save "$data/01. Dataset/01_raw/THIMO2017_IT_DK_KL.dta", replace*/

			clear all
	
	
	use 	"$data/01. Dataset/01_raw/THIMO2017_IT_DK_KL.dta", clear
	append using "$data/01. Dataset/01_raw/THIMO2017_SK_WMK_MC.dta", gen(P1) force
	append using "$data/01. Dataset/01_raw/THIMO2018_SK_WMK_KMC.dta", gen(P2) force
	append using "$data/01. Dataset/01_raw/THIMO2018_NK_BBO_BKK.dta", gen(P3) force
	append using "$data/01. Dataset/01_raw\THIMO2018_IT_BM_LB.dta", gen(P4) force
	*replace auto_pygm="1" if auto_pygm=="Oui"
	*replace auto_pygm="0" if auto_pygm=="Non"
	append using "$data/01. Dataset/01_raw\THIMO2018_IT_BM_GA.dta", gen(P5) force
	append using "$data/01. Dataset/01_raw\THIMO2018_NK_SMK_KN.dta", gen(P6) force
	append using "$data/01. Dataset/01_raw\THIMO2018_NK_SMK_PK.dta", gen(P7) force
	
	append using "$data/01. Dataset/01_raw\THIMO2018_NK_SMK_BK.dta", gen(P8) force
	append using "$data/01. Dataset/01_raw\THIMO2018_NK_SMK_KM.dta", gen(P9) force
	append using "$data/01. Dataset/01_raw\THIMO2018_IT_DF_DN.dta", gen(P10) force
	append using "$data/01. Dataset/01_raw\THIMO2018_IT_DF_KK.dta", gen(P11) force
	append using "$data/01. Dataset/01_raw\THIMO2018_IT_DF_ZSK.dta", gen(P12) force
	append using "$data/01. Dataset/01_raw\THIMO2018_SK_WMK_KBK.dta", gen(P13) force
	append using "$data/01. Dataset/01_raw\THIMO2018_SK_WMK_B.dta", gen(P14) force
	append using "$data/01. Dataset/01_raw\THIMO2018_SK_MBH_UNOPS.dta", gen(P15) force

	append using "$data/01. Dataset/01_raw\THIMO2018_NK_BBO_MM.dta", gen(P16) force
	append using "$data/01. Dataset/01_raw\THIMO2019_SK_MK.dta", gen(P17) force
	append using "$data/01. Dataset/01_raw\BM2019_SP_IT_AS_clean.dta", gen(P18) force
	append using "$data/01. Dataset/01_raw\THIMO2019_NK_BK.dta", gen(P19) force
	append using "$data/01. Dataset/01_raw\THIMO2019_NK_BBO_KV.dta", gen(P20) force
	append using "$data/01. Dataset/01_raw\THIMO2019_NK_BBO_KM.dta", gen(P21) force
	append using "$data/01. Dataset/01_raw\THIMO2018_NK_BBO_MABOA.dta", gen(P22) force
	append using "$data/01. Dataset/01_raw\THIMO2018_NK_BBO_KI.dta", gen(P23) force
	
	drop if village=="Mutingwa/Kakemenge"
	
	replace noms=nom if noms==""
	drop if key=="uuid:a354daae-46fe-431d-baf8-ab57ec7e5384"
	drop if key=="uuid:c64e731c-e381-4055-b9fa-9c656008cb34"
	drop if key=="uuid:f2bcea7f-7b6a-405c-86b0-03465582b41f"
	drop if key=="uuid:b5331ff9-a2f2-4770-ad85-609b281c5f18"
	drop if key=="uuid:f8e0d3cd-2073-4559-991a-595ecc35ee70"
	drop if key=="uuid:34367bbe-faae-4fdc-b0aa-550c0c892c3e"
	drop if key=="uuid:be11fc9a-dd31-4788-a3ac-2c26f2581c6e"
	drop if key=="uuid:d52b46f9-762a-4de8-820c-0c3d4841e4b0"
	drop if key=="uuid:d2fe644f-66d5-4e2f-9e93-24b9e480418d"
	drop if key=="uuid:e98c911f-5d95-42a5-b2fd-72948fd9dbfd"
	drop if key=="uuid:effdd716-eb09-4ecd-821c-0425af268bd5"
	drop if key=="uuid:e2d21c25-7fac-4176-b875-305a6f6f4b5e"
	drop if key=="uuid:4669b3d5-f155-49ea-b678-a0146b07ee9c"
	drop if key=="uuid:bec6b362-098d-49e7-80cb-4b8a7c989522"
	drop if key=="uuid:e7f7edea-b133-4b08-ab06-f6637a9c5a69"
	drop if key=="uuid:463adda6-b32e-4bd3-aa38-68aa64b643bf"
	drop if key=="uuid:1aa6f2cc-fa86-412b-88c7-d139d44f0ff5"
	drop if key=="uuid:9bb2aea6-b126-43c5-829f-1082ed3deac1"
	drop if key=="uuid:5afe2dae-3978-4139-9e78-4ec597a72a97"
	drop if key=="uuid:b6fbdb76-78b8-4229-b87f-06cc0ca4aa11"
	drop if key=="uuid:f73de139-f662-45d7-a8a1-973192b746fc"
	drop if key=="uuid:6c9204e1-f89e-46ce-b928-ca738f081536"
	drop if key=="uuid:c7be9032-6c7e-4ad2-a5cb-1099e9c66152"
	drop if key=="uuid:107fb635-9d30-42f4-8578-42da4c157ce8"
	drop if key=="uuid:d651b3f6-4f55-479a-b584-d19ee50e7940"
	drop if key=="uuid:0d85e960-54db-4bdc-a123-ad4bd398a652"
	drop if key=="uuid:33b4d6ee-0cb9-4b14-838d-879665b8fe9e"
	drop if key=="uuid:e8100d7f-450f-45d6-8cbe-52cd21ca3545"
	drop if key=="uuid:52ab1efd-ced2-4eb1-a7dd-97269d123b29"
	drop if key=="uuid:6bfd5353-4344-4cd9-941e-3d986ad6d5a3"
	drop if key=="uuid:6d0cc261-af5a-43f4-b7a5-ac83758f83eb"
	drop if key=="uuid:1abd72ea-301d-4760-a1e8-80fbff71a60f"
	drop if key=="uuid:e288e856-c2c8-462f-83b5-efa5ddabe65f"
	drop if key=="uuid:908d0cc3-c050-479b-8baa-d853f0821208"
	drop if key=="uuid:f13266d0-dc05-4be6-9c46-f18d86b0ecb2"
	drop if key=="uuid:ab760283-517b-4659-b0f0-5d7344461cdd"
	drop if key=="uuid:706fc6df-ae8f-49b7-9483-d3cd21214459"
	drop if key=="uuid:388174ac-2496-4162-bbee-23e2e860488d"
	drop if key=="uuid:7b4b9d26-ff3a-4b81-b6c2-02f716cb1328"
	drop if key=="uuid:2714da85-a5ff-48cb-928d-6b53e5fb5759"
	drop if key=="uuid:3984cc79-b696-4abd-83a2-0845d799e840"
	drop if key=="uuid:becd28f4-3223-46da-8058-298d3448e853"
	drop if key=="uuid:e20196aa-d48f-4938-b4c5-84e084046f90"
	drop if key=="uuid:e5305aa3-39a2-4a41-8bb6-b4c11912c6a5"
	drop if key=="uuid:73973282-66a1-4692-ac82-563ba5ca892e"
	drop if key=="uuid:04835bf3-9c7b-4910-a858-becb8d96c546"
	drop if key=="uuid:aededb22-1331-4d6b-8367-5edb196579df"
	drop if key=="uuid:8a35139a-d081-497f-9abd-da1c5f8a1ca5"
	drop if key=="uuid:2f6352bd-53aa-4868-8dae-19af95f59aa5"
	drop if key=="uuid:57ca8feb-011a-4ed5-a2d5-2505910bee18"
	drop if key=="uuid:f93fed9b-5508-4faf-aa4c-e9968bdb3579"
	drop if key=="uuid:ec3d87b2-3c7f-4ae3-ae50-74c55462c17f"
	drop if key=="uuid:6321917c-26f0-46da-9872-76215e2efdc9"
	drop if key=="uuid:5e7e56f4-0bd9-4663-9ca4-f7cc7f519750"
	drop if key=="uuid:075f7e67-1361-4c5f-a043-f5fab91e9a0d"
	drop if key=="uuid:30c24d73-77eb-4e15-a799-081cc1a4a9f0"
	drop if key=="uuid:339dd8be-715d-4e85-8c5a-cdb703609e5c"
	drop if key=="uuid:2ab7e9a4-abeb-4d3b-87c1-0f5b757faf4d"
	drop if key=="uuid:8ba732b0-c38a-4671-a37e-f505db08276f"
	drop if key=="uuid:fee0870c-00a6-4942-b5e8-dd09d5f094c0"
	drop if key=="uuid:f8b92cf3-34ca-4219-b0c8-6afb02be01b1"
	drop if hhid==14091 & noms=="MUDERWA  GISELE  BASHONGA"
	replace village="AGUBA" if village=="Aguba"
	replace village="ANDIRI" if village=="Andiri"
	replace village="ANGUANDI" if village=="Anguandi"
	replace village="ATADRA" if village=="Atadra"
	replace village="AZABA" if village=="Azaba"
	replace village="AZILE" if village=="Azile"
	replace village="BAABE" if village=="Baabe"
	replace village="BAVA" if village=="Bava"
	replace village="BETESAIDA" if village=="Betesaida"
	replace village="BILALOMBILI" if village=="Bilalombili"
	replace village="BIRAVA_CENTRE" if village=="Birava Centre"
	replace village="BIRIKULU_MISSION" if village=="Birikulu_Mission"
	replace village="BRUXEL" if village=="Bruxel"
	replace village="BULONGE" if village=="Bulonge"
	replace village="BUNGI" if village=="Bungi"
	replace village="BUNYESI" if village=="Bunyesi"
	replace village="BUSHUMBA" if village=="Bushumba"
	replace village="BUTUHE" if village=="Butuhe"
	replace village="Bwiralike" if village=="BWIRALIKE"
	replace village="BYONGA 1" if village=="Byonga 1"
	replace village="CABUNDA_CENTRE" if village=="Cabunda Centre"
	replace village="CHIGOMA_MWANDA" if village=="Chigoma /Mwanda"
	replace village="CHOMBO" if village=="Chombo"
	replace village="Cibeke" if village=="CIBEKE"
	replace village="CIBINDA" if village=="Cibinda"
	replace village="CIGOMA" if village=="Cigoma"
	replace village="Ciherano" if village=="CIHERANO"
	replace village="CIRAMANZI_KITANDI" if village=="Ciramanzi/Kitandi"
	replace village="DRASUMA" if village=="Drasuma"
	replace village="EKUNGA" if village=="Ekunga"
	replace village="GBODRA" if village=="Gbodra"
	replace village="HEMBE" if village=="Hembe"
	replace village="HUNGU" if village=="Hungu"
	replace village="IGANDA" if village=="Iganda"
	replace village="IRONGA" if village=="Ironga"
	replace village="KAA" if village=="Kaa"
	replace village="KABASHA" if village=="Kabasha"
	replace village="KABENDE" if village=="Kabende"
	replace village="KABULWA" if village=="Kabulwa"
	replace village="KAHAMBA" if village=="Kahamba"
	replace village="KAHESI1_HEMBE" if village=="Kahesi1/Hembe"
	replace village="KAHESI2" if village=="Kahesi2"
	replace village="KAHINGA_1" if village=="Kahinga 1"
	replace village="KAIRENGE" if village=="Kairenge"
	replace village="KAKOBA" if village=="Kakoba"
	replace village="KALELE NGANDO" if village=="Kalele Ngando"
	replace village="KALIMBI" if village=="Kalimbi"
	replace village="KAMARADE" if village=="Kamarade"
	replace village="KAMBALE-MUJI" if village=="Kambale Muji"
	replace village="KANGAMBO" if village=="Kangambo"
	replace village="KARASI" if village=="Karasi"
	replace village="KASALALO" if village=="Kasalalo"
	replace village="KASHOMBE" if village=="Kashombe"
	replace village="KATHEMBO" if village=="Kathembo"
	replace village="KATOBOLO" if village=="Katobolo"
	replace village="KAYINGA2" if village=="Kayinga2"
	replace village="KICANGA" if village=="Kicanga"
	replace village="KIHARO" if village=="Kiharo"
	replace village="KIKERE" if village=="Kikere"
	replace village="KINKUMA" if village=="Kinkuma"
	replace village="KIPONA_1" if village=="Kipona 1"
	replace village="KIPONA_2" if village=="Kipona 2"
	replace village="KISONGO" if village=="Kisongo"
	replace village="KISUBI" if village=="Kisubi"
	replace village="KITAMBA" if village=="Kitamba"
	replace village="KITAMBALA" if village=="Kitambala"
	replace village="KONDJIAMA" if village=="Kondjiama"
	replace village="KUNBGU" if village=="Kunbgu"
	replace village="LAVURU" if village=="Lavuru"
	replace village="LUHIHI_CENTRE" if village=="Luhihi Centre"
	replace village="Lulonge I et II" if village=="Lulonge"
	replace village="LWANGOMA" if village=="Lwangoma"
	replace village="MADRANGBO" if village=="Madrangbo"
	replace village="MAIBANO" if village=="Maibano"
	replace village="MAIBU" if village=="Maibu"
	replace village="MALONGE" if village=="Malonge"
	replace village="MANDARA" if village=="Mandara"
	replace village="MANGUYA" if village=="Manguya"
	replace village="MAPEMA" if village=="Mapema"
	replace village="MAROC" if village=="Maroc"
	replace village="MASANGA_TUKENGA_2" if village=="Masanga/Tukenga 2"
	replace village="MBELEKELO" if village=="Mbelekelo"
	replace village="MELA_KISANI" if village=="Mela/Kisani"
	replace village="MELA_LUPIMBI" if village=="Mela/Lupimbi"
	replace village="MELA_LUSUNGU" if village=="Mela/Lusungu"
	replace village="MELA_MASANGA" if village=="Mela/Masanga"
	replace village="MIHOKE" if village=="Mihoke"
	replace village="MIKONZI" if village=="Mikonzi"
	replace village="MITI_CENTRE" if village=="Miti Centre"
	replace village="MIZULO" if village=="Mizulo"
	replace village="Mubone" if village=="MUBONE"
	replace village="MUHELA" if village=="Muhela"
	replace village="MUKABA" if village=="Mukaba"
	replace village="MUSHWESHE" if village=="Mushweshe"
	replace village="Mwenga centre" if village=="Mwenga Centre"
	replace village="NGANZI" if village=="Nganzi"
	replace village="NYALUBANBA" if village=="Nyalubanba"
	replace village="NYAMABULUGU" if village=="Nyamabulugu"
	replace village="NYANGOMA" if village=="Nyangoma"
	replace village="RIAMA" if village=="Riama"
	replace village="SABUNI" if village=="Sabuni"
	replace village="SUNGWE CENTRE" if village=="Sungwe Centre"
	replace village="ZORO" if village=="Zoro"
	replace village="ZUMAI" if village=="Zumai"

	
	drop if village==""
	
	replace JetonlistePrincipale="33" if JetonlistePrincipale=="033(5)"
	replace JetonlistePrincipale="102" if JetonlistePrincipale=="102(12)"
	replace JetonlistePrincipale="10" if JetonlistePrincipale=="010(3)"
	replace JetonlistePrincipale="28" if JetonlistePrincipale=="028(11)"
	replace JetonlistePrincipale="120" if JetonlistePrincipale=="120(4)"
	replace JetonlistePrincipale="101" if JetonlistePrincipale=="101(1)"
	replace JetonlistePrincipale="122" if JetonlistePrincipale=="122(8)"
	replace JetonlistePrincipale="3" if JetonlistePrincipale=="003(9)"
	replace JetonlistePrincipale="22" if JetonlistePrincipale=="022(13)"
	replace JetonlistePrincipale="108" if JetonlistePrincipale=="108(10)"
	replace JetonlistePrincipale="105" if JetonlistePrincipale=="0105(14)"
	replace JetonlistePrincipale="2" if JetonlistePrincipale=="002(7)"
	replace JetonlistePrincipale="90" if JetonlistePrincipale=="090(2)"
	replace JetonlistePrincipale="112" if JetonlistePrincipale=="112(6)"
	replace JetonlistePrincipale="31" if JetonlistePrincipale=="031(11)"
	replace JetonlistePrincipale="12" if JetonlistePrincipale=="012(1)"
	replace JetonlistePrincipale="36" if JetonlistePrincipale=="036(7)"
	replace JetonlistePrincipale="60" if JetonlistePrincipale=="060(6)"
	replace JetonlistePrincipale="38" if JetonlistePrincipale=="038(9)"
	replace JetonlistePrincipale="59" if JetonlistePrincipale=="059(8)"
	replace JetonlistePrincipale="48" if JetonlistePrincipale=="048(10)"
	replace JetonlistePrincipale="40" if JetonlistePrincipale=="040(3)"
	replace JetonlistePrincipale="84" if JetonlistePrincipale=="084(4)"
	replace JetonlistePrincipale="86" if JetonlistePrincipale=="086(2)"
	replace JetonlistePrincipale="5" if JetonlistePrincipale=="005(5)"
	replace JetonlistePrincipale="25" if JetonlistePrincipale=="25(7)"
	replace JetonlistePrincipale="2" if JetonlistePrincipale=="2(9)"
	replace JetonlistePrincipale="82" if JetonlistePrincipale=="82(4)"
	replace JetonlistePrincipale="71" if JetonlistePrincipale=="71(10)"
	replace JetonlistePrincipale="48" if JetonlistePrincipale=="48(2)"
	replace JetonlistePrincipale="81" if JetonlistePrincipale=="81(8)"
	replace JetonlistePrincipale="30" if JetonlistePrincipale=="30(6)"
	replace JetonlistePrincipale="23" if JetonlistePrincipale=="23(5)"
	replace JetonlistePrincipale="10" if JetonlistePrincipale=="10(1)"
	replace JetonlistePrincipale="22" if JetonlistePrincipale=="22(3)"
	replace JetonlistePrincipale="12" if JetonlistePrincipale=="12(3)"
	replace JetonlistePrincipale="10" if JetonlistePrincipale=="10(5)"
	replace JetonlistePrincipale="49" if JetonlistePrincipale=="49(4)"
	replace JetonlistePrincipale="20" if JetonlistePrincipale=="20(7)"
	replace JetonlistePrincipale="65" if JetonlistePrincipale=="65(6)"
	replace JetonlistePrincipale="30" if JetonlistePrincipale=="30(1)"
	replace JetonlistePrincipale="35" if JetonlistePrincipale=="35(8)"
	replace JetonlistePrincipale="52" if JetonlistePrincipale=="52(2)"
	replace JetonlistePrincipale="6" if JetonlistePrincipale=="6(9)"
	replace JetonlistePrincipale="49" if JetonlistePrincipale=="49(2)"
	replace JetonlistePrincipale="11" if JetonlistePrincipale=="11(5)"
	replace JetonlistePrincipale="53" if JetonlistePrincipale=="53(4)"
	replace JetonlistePrincipale="17" if JetonlistePrincipale=="17(3)"
	replace JetonlistePrincipale="33" if JetonlistePrincipale=="33(7)"
	replace JetonlistePrincipale="69" if JetonlistePrincipale=="69(6)"
	replace JetonlistePrincipale="16" if JetonlistePrincipale=="16(1)"
	replace JetonlistePrincipale="47" if JetonlistePrincipale=="47(8)"
	replace JetonlistePrincipale="1" if JetonlistePrincipale=="1(1)"
	replace JetonlistePrincipale="2" if JetonlistePrincipale=="2(1)"
	replace JetonlistePrincipale="20" if JetonlistePrincipale=="20(3)"
	replace JetonlistePrincipale="12" if JetonlistePrincipale=="12(5)"
	replace JetonlistePrincipale="36" if JetonlistePrincipale=="36(2)"
	replace JetonlistePrincipale="4" if JetonlistePrincipale=="4(7)"
	replace JetonlistePrincipale="58" if JetonlistePrincipale=="58(4)"
	replace JetonlistePrincipale="28" if JetonlistePrincipale=="28(6)"
	replace JetonlistePrincipale="69" if JetonlistePrincipale=="69(12)"
	replace JetonlistePrincipale="14" if JetonlistePrincipale=="14(11)"
	replace JetonlistePrincipale="64" if JetonlistePrincipale=="64(2)"
	replace JetonlistePrincipale="38" if JetonlistePrincipale=="38(3)"
	replace JetonlistePrincipale="106" if JetonlistePrincipale=="106(7)"
	replace JetonlistePrincipale="59" if JetonlistePrincipale=="59(4)"
	replace JetonlistePrincipale="24" if JetonlistePrincipale=="24(11)"
	replace JetonlistePrincipale="66" if JetonlistePrincipale=="66(8)"
	replace JetonlistePrincipale="52" if JetonlistePrincipale=="52(14)"
	replace JetonlistePrincipale="46" if JetonlistePrincipale=="46(6)"
	replace JetonlistePrincipale="15" if JetonlistePrincipale=="15(9)"
	replace JetonlistePrincipale="35" if JetonlistePrincipale=="35(5)"
	replace JetonlistePrincipale="54" if JetonlistePrincipale=="54(10)"
	replace JetonlistePrincipale="17" if JetonlistePrincipale=="17(13)"
	replace JetonlistePrincipale="33" if JetonlistePrincipale=="033(4)"
	replace JetonlistePrincipale="7" if JetonlistePrincipale=="007(1)"
	replace JetonlistePrincipale="4" if JetonlistePrincipale=="004(3)"
	replace JetonlistePrincipale="19" if JetonlistePrincipale=="019(2)"
	replace JetonlistePrincipale="68" if JetonlistePrincipale=="68(9)"
	replace JetonlistePrincipale="182" if JetonlistePrincipale=="182(16)"
	replace JetonlistePrincipale="169" if JetonlistePrincipale=="169(4)"
	replace JetonlistePrincipale="57" if JetonlistePrincipale=="57(11)"
	replace JetonlistePrincipale="46" if JetonlistePrincipale=="46(7)"
	replace JetonlistePrincipale="27" if JetonlistePrincipale=="27(17)"
	replace JetonlistePrincipale="139" if JetonlistePrincipale=="139(8)"
	replace JetonlistePrincipale="78" if JetonlistePrincipale=="78(13)"
	replace JetonlistePrincipale="104" if JetonlistePrincipale=="104(18)"
	replace JetonlistePrincipale="71" if JetonlistePrincipale=="71(21)"
	replace JetonlistePrincipale="90" if JetonlistePrincipale=="90(12)"
	replace JetonlistePrincipale="125" if JetonlistePrincipale=="125(20)"
	replace JetonlistePrincipale="6" if JetonlistePrincipale=="6(15)"
	replace JetonlistePrincipale="31" if JetonlistePrincipale=="31(19)"
	replace JetonlistePrincipale="70" if JetonlistePrincipale=="70(1)"
	replace JetonlistePrincipale="142" if JetonlistePrincipale=="142(10)"
	replace JetonlistePrincipale="80" if JetonlistePrincipale=="80(3)"
	replace JetonlistePrincipale="74" if JetonlistePrincipale=="74(5)"
	replace JetonlistePrincipale="107" if JetonlistePrincipale=="107(6)"
	replace JetonlistePrincipale="131" if JetonlistePrincipale=="131(2)"
	replace JetonlistePrincipale="123" if JetonlistePrincipale=="123(14)"
	replace JetonlistePrincipale="5" if JetonlistePrincipale=="005(1)"
	replace JetonlistePrincipale="12" if JetonlistePrincipale=="012(2)"
	replace JetonlistePrincipale="13" if JetonlistePrincipale=="13(2)"
	replace JetonlistePrincipale="7" if JetonlistePrincipale=="7(1)"
	replace JetonlistePrincipale="4" if JetonlistePrincipale=="4(3)"
	replace JetonlistePrincipale="39" if JetonlistePrincipale=="039(4)"
	replace JetonlistePrincipale="5" if JetonlistePrincipale=="005(1)"
	replace JetonlistePrincipale="18" if JetonlistePrincipale=="018(2)"
	replace JetonlistePrincipale="9" if JetonlistePrincipale=="009(3)"
	replace JetonlistePrincipale="4" if JetonlistePrincipale=="004(5)"
	replace JetonlistePrincipale="1" if JetonlistePrincipale=="1(1)"
	replace JetonlistePrincipale="11" if JetonlistePrincipale=="11(2)"
	replace JetonlistePrincipale="9" if JetonlistePrincipale=="9(3)"
	replace JetonlistePrincipale="8" if JetonlistePrincipale=="8(1)"
	replace JetonlistePrincipale="18" if JetonlistePrincipale=="18(2)"
	replace JetonlistePrincipale="48" if JetonlistePrincipale=="48(2)"
	replace JetonlistePrincipale="73" if JetonlistePrincipale=="73(6)"
	replace JetonlistePrincipale="17" if JetonlistePrincipale=="17(3)"
	replace JetonlistePrincipale="32" if JetonlistePrincipale=="32(1)"
	replace JetonlistePrincipale="28" if JetonlistePrincipale=="28(9)"
	replace JetonlistePrincipale="81" if JetonlistePrincipale=="81(4)"
	replace JetonlistePrincipale="7" if JetonlistePrincipale=="7(5)"
	replace JetonlistePrincipale="35" if JetonlistePrincipale=="35(7)"
	replace JetonlistePrincipale="52" if JetonlistePrincipale=="52(8)"
	replace JetonlistePrincipale="22" if JetonlistePrincipale=="22(2)"
	replace JetonlistePrincipale="1" if JetonlistePrincipale=="1(1)"
	replace JetonlistePrincipale="3" if JetonlistePrincipale=="3(3)"
	replace JetonlistePrincipale="3" if JetonlistePrincipale=="003(1)"
	replace JetonlistePrincipale="19" if JetonlistePrincipale=="019(2)"
	replace JetonlistePrincipale="1" if JetonlistePrincipale=="1(1)"
	replace JetonlistePrincipale="5" if JetonlistePrincipale=="005(3)"
	replace JetonlistePrincipale="4" if JetonlistePrincipale=="004(9)"
	replace JetonlistePrincipale="23" if JetonlistePrincipale=="023(1)"
	replace JetonlistePrincipale="39" if JetonlistePrincipale=="039(2)"
	replace JetonlistePrincipale="34" if JetonlistePrincipale=="034(4)"
	replace JetonlistePrincipale="41" if JetonlistePrincipale=="041(6)"
	replace JetonlistePrincipale="11" if JetonlistePrincipale=="011(5)"
	replace JetonlistePrincipale="31" if JetonlistePrincipale=="031(7)"
	replace JetonlistePrincipale="48" if JetonlistePrincipale=="048(8)"
	replace JetonlistePrincipale="14" if JetonlistePrincipale=="014(5)"
	replace JetonlistePrincipale="25" if JetonlistePrincipale=="025(2)"
	replace JetonlistePrincipale="15" if JetonlistePrincipale=="015(3)"
	replace JetonlistePrincipale="60" if JetonlistePrincipale=="060(6)"
	replace JetonlistePrincipale="4" if JetonlistePrincipale=="004(1)"
	replace JetonlistePrincipale="45" if JetonlistePrincipale=="045(4)"
	replace JetonlistePrincipale="13" if JetonlistePrincipale=="013(7)"
	replace JetonlistePrincipale="43" if JetonlistePrincipale=="43(5)"
	replace JetonlistePrincipale="53" if JetonlistePrincipale=="53(4)"
	replace JetonlistePrincipale="29" if JetonlistePrincipale=="29(3)"
	replace JetonlistePrincipale="23" if JetonlistePrincipale=="23(11)"
	replace JetonlistePrincipale="94" if JetonlistePrincipale=="94(10)"
	replace JetonlistePrincipale="6" if JetonlistePrincipale=="6(7)"
	replace JetonlistePrincipale="95" if JetonlistePrincipale=="95(8)"
	replace JetonlistePrincipale="13" if JetonlistePrincipale=="13(9)"
	replace JetonlistePrincipale="54" if JetonlistePrincipale=="54(2)"
	replace JetonlistePrincipale="67" if JetonlistePrincipale=="67(6)"
	replace JetonlistePrincipale="19" if JetonlistePrincipale=="19(1)"
	replace JetonlistePrincipale="5" if JetonlistePrincipale=="005(3)"
	replace JetonlistePrincipale="4" if JetonlistePrincipale=="004(1)"
	replace JetonlistePrincipale="63" if JetonlistePrincipale=="063(7)"
	replace JetonlistePrincipale="1" if JetonlistePrincipale=="001(002)"
	replace JetonlistePrincipale="3" if JetonlistePrincipale=="003(9))"
	replace JetonlistePrincipale="7" if JetonlistePrincipale=="007(5)"
	replace JetonlistePrincipale="51" if JetonlistePrincipale=="051(06)"
	replace JetonlistePrincipale="65" if JetonlistePrincipale=="065(4)"
	replace JetonlistePrincipale="39" if JetonlistePrincipale=="039(8)"
	replace JetonlistePrincipale="11" if JetonlistePrincipale=="11(1)"
	replace JetonlistePrincipale="17" if JetonlistePrincipale=="17(2)"
	replace JetonlistePrincipale="15" if JetonlistePrincipale=="015(2)"
	replace JetonlistePrincipale="3" if JetonlistePrincipale=="003(1)"
	replace JetonlistePrincipale="4" if JetonlistePrincipale=="4(1)"
	replace JetonlistePrincipale="175" if JetonlistePrincipale=="175(31)"
	replace JetonlistePrincipale="119" if JetonlistePrincipale=="119(23)"
	replace JetonlistePrincipale="90" if JetonlistePrincipale=="090(15)"
	replace JetonlistePrincipale="244" if JetonlistePrincipale=="244(2)"
	replace JetonlistePrincipale="204" if JetonlistePrincipale=="204(22)"
	replace JetonlistePrincipale="216" if JetonlistePrincipale=="216(6)"
	replace JetonlistePrincipale="48" if JetonlistePrincipale=="048(33)"
	replace JetonlistePrincipale="8" if JetonlistePrincipale=="008(13)"
	replace JetonlistePrincipale="290" if JetonlistePrincipale=="290(30)"
	replace JetonlistePrincipale="259" if JetonlistePrincipale=="259(8)"
	replace JetonlistePrincipale="118" if JetonlistePrincipale=="118(7)"
	replace JetonlistePrincipale="41" if JetonlistePrincipale=="041(27)"
	replace JetonlistePrincipale="209" if JetonlistePrincipale=="209(26)"
	replace JetonlistePrincipale="224" if JetonlistePrincipale=="224(24)"
	replace JetonlistePrincipale="11" if JetonlistePrincipale=="011(17)"
	replace JetonlistePrincipale="282" if JetonlistePrincipale=="282(28)"
	replace JetonlistePrincipale="163" if JetonlistePrincipale=="163(5)"
	replace JetonlistePrincipale="12" if JetonlistePrincipale=="012(11)"
	replace JetonlistePrincipale="9" if JetonlistePrincipale=="009(21)"
	replace JetonlistePrincipale="245" if JetonlistePrincipale=="245(16)"
	replace JetonlistePrincipale="21" if JetonlistePrincipale=="021(29)"
	replace JetonlistePrincipale="228" if JetonlistePrincipale=="228(14)"
	replace JetonlistePrincipale="213" if JetonlistePrincipale=="213(4)"
	replace JetonlistePrincipale="51" if JetonlistePrincipale=="051(25)"
	replace JetonlistePrincipale="199" if JetonlistePrincipale=="199(18)"
	replace JetonlistePrincipale="94" if JetonlistePrincipale=="094(9)"
	replace JetonlistePrincipale="47" if JetonlistePrincipale=="47(3)"
	replace JetonlistePrincipale="280" if JetonlistePrincipale=="280(20)"
	replace JetonlistePrincipale="196" if JetonlistePrincipale=="196(32)"
	replace JetonlistePrincipale="107" if JetonlistePrincipale=="107(1)"
	replace JetonlistePrincipale="243" if JetonlistePrincipale=="243(12)"
	replace JetonlistePrincipale="262" if JetonlistePrincipale=="262(10)"
	replace JetonlistePrincipale="9" if JetonlistePrincipale=="9(2)"
	replace JetonlistePrincipale="1" if JetonlistePrincipale=="1(1)"
	replace JetonlistePrincipale="24" if JetonlistePrincipale=="24(3)"
	replace JetonlistePrincipale="1" if JetonlistePrincipale=="1(1)"
	replace JetonlistePrincipale="20" if JetonlistePrincipale=="20(2)"
	replace JetonlistePrincipale="88" if JetonlistePrincipale=="88(4)"
	replace JetonlistePrincipale="21" if JetonlistePrincipale=="21(3)"
	replace JetonlistePrincipale="16" if JetonlistePrincipale=="16(7)"
	replace JetonlistePrincipale="17" if JetonlistePrincipale=="17(11)"
	replace JetonlistePrincipale="74" if JetonlistePrincipale=="74(6)"
	replace JetonlistePrincipale="70" if JetonlistePrincipale=="70(8)"
	replace JetonlistePrincipale="27" if JetonlistePrincipale=="27(10)"
	replace JetonlistePrincipale="2" if JetonlistePrincipale=="2(9)"
	replace JetonlistePrincipale="62" if JetonlistePrincipale=="62(2)"
	replace JetonlistePrincipale="6" if JetonlistePrincipale=="6(1)"
	replace JetonlistePrincipale="18" if JetonlistePrincipale=="18(5)"
	replace JetonlistePrincipale="5" if JetonlistePrincipale=="5(1)"
	replace JetonlistePrincipale="17" if JetonlistePrincipale=="17(4)"
	replace JetonlistePrincipale="25" if JetonlistePrincipale=="25(2)"
	replace JetonlistePrincipale="37" if JetonlistePrincipale=="37(6)"
	replace JetonlistePrincipale="1" if JetonlistePrincipale=="1(5)"
	replace JetonlistePrincipale="2" if JetonlistePrincipale=="2(9)"
	replace JetonlistePrincipale="4" if JetonlistePrincipale=="4(3)"
	replace JetonlistePrincipale="29" if JetonlistePrincipale=="29(8)"
	replace JetonlistePrincipale="3" if JetonlistePrincipale=="3(7)"
	replace JetonlistePrincipale="133" if JetonlistePrincipale=="133(8)"
	replace JetonlistePrincipale="150" if JetonlistePrincipale=="150 (12)"
	replace JetonlistePrincipale="40" if JetonlistePrincipale=="040(13)"
	replace JetonlistePrincipale="56" if JetonlistePrincipale=="056(1)"
	replace JetonlistePrincipale="104" if JetonlistePrincipale=="104(10)"
	replace JetonlistePrincipale="122" if JetonlistePrincipale=="122(18)"
	replace JetonlistePrincipale="100" if JetonlistePrincipale=="100(4)"
	replace JetonlistePrincipale="55" if JetonlistePrincipale=="055(7)"
	replace JetonlistePrincipale="144" if JetonlistePrincipale=="144(2)"
	replace JetonlistePrincipale="76" if JetonlistePrincipale=="076(9)"
	replace JetonlistePrincipale="108" if JetonlistePrincipale=="108(14)"
	replace JetonlistePrincipale="50" if JetonlistePrincipale=="050(15)"
	replace JetonlistePrincipale="54" if JetonlistePrincipale=="054(17)"
	replace JetonlistePrincipale="30" if JetonlistePrincipale=="030(11)"
	replace JetonlistePrincipale="31" if JetonlistePrincipale=="031(19)"
	replace JetonlistePrincipale="102" if JetonlistePrincipale=="102(6)"
	replace JetonlistePrincipale="18" if JetonlistePrincipale=="018(5)"
	replace JetonlistePrincipale="15" if JetonlistePrincipale=="015(3)"
	replace JetonlistePrincipale="119" if JetonlistePrincipale=="119(16)"
	replace JetonlistePrincipale="2" if JetonlistePrincipale=="002(1)"
	replace JetonlistePrincipale="3" if JetonlistePrincipale=="003(5)"
	replace JetonlistePrincipale="14" if JetonlistePrincipale=="014(9)"
	replace JetonlistePrincipale="70" if JetonlistePrincipale=="070(2)"
	replace JetonlistePrincipale="7" if JetonlistePrincipale=="007(3)"
	replace JetonlistePrincipale="65" if JetonlistePrincipale=="065(6)"
	replace JetonlistePrincipale="55" if JetonlistePrincipale=="055(8)"
	replace JetonlistePrincipale="43" if JetonlistePrincipale=="043(4)"
	replace JetonlistePrincipale="38" if JetonlistePrincipale=="038(7)"
	replace JetonlistePrincipale="47" if JetonlistePrincipale=="047(4)"
	replace JetonlistePrincipale="21" if JetonlistePrincipale=="021(5)"
	replace JetonlistePrincipale="34" if JetonlistePrincipale=="034(6)"
	replace JetonlistePrincipale="14" if JetonlistePrincipale=="014(7)"
	replace JetonlistePrincipale="11" if JetonlistePrincipale=="011(1)"
	replace JetonlistePrincipale="16" if JetonlistePrincipale=="016(3)"
	replace JetonlistePrincipale="39" if JetonlistePrincipale=="039(2)"
	replace JetonlistePrincipale="1" if JetonlistePrincipale=="001(3)"
	replace JetonlistePrincipale="12" if JetonlistePrincipale=="012(2)"
	replace JetonlistePrincipale="5" if JetonlistePrincipale=="005(1)"
	replace JetonlistePrincipale="4" if JetonlistePrincipale=="004(3)"
	replace JetonlistePrincipale="10" if JetonlistePrincipale=="010(1)"
	replace JetonlistePrincipale="22" if JetonlistePrincipale=="022(2)"
	replace JetonlistePrincipale="32" if JetonlistePrincipale=="032(4)"
	replace JetonlistePrincipale="27" if JetonlistePrincipale=="027(2)"
	replace JetonlistePrincipale="4" if JetonlistePrincipale=="004(1)"
	replace JetonlistePrincipale="5" if JetonlistePrincipale=="005(3)"
	replace JetonlistePrincipale="19" if JetonlistePrincipale=="019(4)"
	replace JetonlistePrincipale="19" if JetonlistePrincipale=="019(1)"
	replace JetonlistePrincipale="10" if JetonlistePrincipale=="010(2)"
	replace JetonlistePrincipale="3" if JetonlistePrincipale=="003(1)"
	replace JetonlistePrincipale="18" if JetonlistePrincipale=="018(2)"
	replace JetonlistePrincipale="16" if JetonlistePrincipale=="016(4)"
	replace JetonlistePrincipale="29" if JetonlistePrincipale=="029(3)"

	replace Jetonlisteprincipale="7" if Jetonlisteprincipale=="007(9)"
	replace Jetonlisteprincipale="4" if Jetonlisteprincipale=="004(1)"
	replace Jetonlisteprincipale="37" if Jetonlisteprincipale=="037(20"
	replace Jetonlisteprincipale="35" if Jetonlisteprincipale=="035(8)"
	replace Jetonlisteprincipale="26" if Jetonlisteprincipale=="026(3)"
	replace Jetonlisteprincipale="27" if Jetonlisteprincipale=="027(6)"
	replace Jetonlisteprincipale="6" if Jetonlisteprincipale=="006(7)"
	replace Jetonlisteprincipale="3" if Jetonlisteprincipale=="003(4)"
	replace Jetonlisteprincipale="8" if Jetonlisteprincipale=="008(5)"
	replace Jetonlisteprincipale="16" if Jetonlisteprincipale=="016(1)"
	replace Jetonlisteprincipale="38" if Jetonlisteprincipale=="038(7)"
	replace Jetonlisteprincipale="29" if Jetonlisteprincipale=="029(3)"
	replace Jetonlisteprincipale="37" if Jetonlisteprincipale=="037(5)"
	replace Jetonlisteprincipale="3" if Jetonlisteprincipale=="003(11)"
	replace Jetonlisteprincipale="1" if Jetonlisteprincipale=="001(8)"
	replace Jetonlisteprincipale="8" if Jetonlisteprincipale=="008(2)"
	replace Jetonlisteprincipale="47" if Jetonlisteprincipale=="047(4)"
	replace Jetonlisteprincipale="33" if Jetonlisteprincipale=="033(10)"
	replace Jetonlisteprincipale="12" if Jetonlisteprincipale=="012(6)"
	replace Jetonlisteprincipale="53" if Jetonlisteprincipale=="053(9)"
	replace Jetonlisteprincipale="18" if Jetonlisteprincipale=="018(3)"
	replace Jetonlisteprincipale="19" if Jetonlisteprincipale=="019(2)"
	replace Jetonlisteprincipale="5" if Jetonlisteprincipale=="005(4)"
	replace Jetonlisteprincipale="12" if Jetonlisteprincipale=="012(1)"
	replace Jetonlisteprincipale="37" if Jetonlisteprincipale=="037(11)"
	replace Jetonlisteprincipale="52" if Jetonlisteprincipale=="052(3)"
	replace Jetonlisteprincipale="36" if Jetonlisteprincipale=="036(9)"
	replace Jetonlisteprincipale="26" if Jetonlisteprincipale=="026(2)"
	replace Jetonlisteprincipale="50" if Jetonlisteprincipale=="050(4)"
	replace Jetonlisteprincipale="54" if Jetonlisteprincipale=="054(5)"
	replace Jetonlisteprincipale="21" if Jetonlisteprincipale=="021(1)"
	replace Jetonlisteprincipale="14" if Jetonlisteprincipale=="014(8)"
	replace Jetonlisteprincipale="27" if Jetonlisteprincipale=="027(7)"
	replace Jetonlisteprincipale="4" if Jetonlisteprincipale=="004(6)"
	replace Jetonlisteprincipale="59" if Jetonlisteprincipale=="059(10)"
	replace Jetonlisteprincipale="115" if Jetonlisteprincipale=="115 (3)"
	replace Jetonlisteprincipale="101" if Jetonlisteprincipale=="101 (21)"
	replace Jetonlisteprincipale="61" if Jetonlisteprincipale=="061 (10)"
	replace Jetonlisteprincipale="125" if Jetonlisteprincipale=="125 (12)"
	replace Jetonlisteprincipale="39" if Jetonlisteprincipale=="039 (8)"
	replace Jetonlisteprincipale="74" if Jetonlisteprincipale=="074 (15)"
	replace Jetonlisteprincipale="114" if Jetonlisteprincipale=="114 (6)"
	replace Jetonlisteprincipale="68" if Jetonlisteprincipale=="068 (9)"
	replace Jetonlisteprincipale="81" if Jetonlisteprincipale=="081 (20)"
	replace Jetonlisteprincipale="88" if Jetonlisteprincipale=="088 (18)"
	replace Jetonlisteprincipale="90" if Jetonlisteprincipale=="090 (13)"
	replace Jetonlisteprincipale="27" if Jetonlisteprincipale=="027 (23)"
	replace Jetonlisteprincipale="22" if Jetonlisteprincipale=="022 (17)"
	replace Jetonlisteprincipale="11" if Jetonlisteprincipale=="011 (22)"
	replace Jetonlisteprincipale="100" if Jetonlisteprincipale=="100 (1)"
	replace Jetonlisteprincipale="109" if Jetonlisteprincipale=="109 (7)"
	replace Jetonlisteprincipale="93" if Jetonlisteprincipale=="093 (4)"
	replace Jetonlisteprincipale="69" if Jetonlisteprincipale=="069 (14)"
	replace Jetonlisteprincipale="110" if Jetonlisteprincipale=="110 (11)"
	replace Jetonlisteprincipale="86" if Jetonlisteprincipale=="086 (5)"
	replace Jetonlisteprincipale="9" if Jetonlisteprincipale=="009 (19)"
	replace Jetonlisteprincipale="73" if Jetonlisteprincipale=="073 (12)"
	replace Jetonlisteprincipale="102" if Jetonlisteprincipale=="102 (2)"
	replace Jetonlisteprincipale="18" if Jetonlisteprincipale=="018 (17)"
	replace Jetonlisteprincipale="15" if Jetonlisteprincipale=="015 (1)"
	replace Jetonlisteprincipale="88" if Jetonlisteprincipale=="088 (19)"
	replace Jetonlisteprincipale="75" if Jetonlisteprincipale=="075 (3)"
	replace Jetonlisteprincipale="22" if Jetonlisteprincipale=="022 (6)"
	replace Jetonlisteprincipale="58" if Jetonlisteprincipale=="058 (11)"
	replace Jetonlisteprincipale="19" if Jetonlisteprincipale=="019 (9)"
	replace Jetonlisteprincipale="107" if Jetonlisteprincipale=="107 (12)"
	replace Jetonlisteprincipale="9" if Jetonlisteprincipale=="009 (4)"
	replace Jetonlisteprincipale="53" if Jetonlisteprincipale=="053 (8)"
	replace Jetonlisteprincipale="3" if Jetonlisteprincipale=="003 (5)"
	replace Jetonlisteprincipale="11" if Jetonlisteprincipale=="011 (2)"
	replace Jetonlisteprincipale="97" if Jetonlisteprincipale=="097 (14)"
	replace Jetonlisteprincipale="87" if Jetonlisteprincipale=="087 (14)"
	replace Jetonlisteprincipale="70" if Jetonlisteprincipale=="070 (15)"
	replace Jetonlisteprincipale="10" if Jetonlisteprincipale=="010 (16)"
	replace Jetonlisteprincipale="83" if Jetonlisteprincipale=="083 (10)"
	replace Jetonlisteprincipale="81" if Jetonlisteprincipale=="081 (18)"
	replace Jetonlisteprincipale="62" if Jetonlisteprincipale=="062 (7)"
	replace Jetonlisteprincipale="29" if Jetonlisteprincipale=="029 (5)"
	replace Jetonlisteprincipale="22" if Jetonlisteprincipale=="022 (4)"
	replace Jetonlisteprincipale="26" if Jetonlisteprincipale=="026 (3)"
	replace Jetonlisteprincipale="12" if Jetonlisteprincipale=="012 (1)"
	replace Jetonlisteprincipale="9" if Jetonlisteprincipale=="009 (2)"
	replace Jetonlisteprincipale="24" if Jetonlisteprincipale=="024 (6)"
	replace Jetonlisteprincipale="66" if Jetonlisteprincipale=="066 (6)"
	replace Jetonlisteprincipale="86" if Jetonlisteprincipale=="086 (18)"
	replace Jetonlisteprincipale="106" if Jetonlisteprincipale=="106 (8)"
	replace Jetonlisteprincipale="108" if Jetonlisteprincipale=="108 (11)"
	replace Jetonlisteprincipale="21" if Jetonlisteprincipale=="021 (16)"
	replace Jetonlisteprincipale="8" if Jetonlisteprincipale=="008 (13)"
	replace Jetonlisteprincipale="70" if Jetonlisteprincipale=="070 (1)"
	replace Jetonlisteprincipale="36" if Jetonlisteprincipale=="036 (7)"
	replace Jetonlisteprincipale="117" if Jetonlisteprincipale=="117 (20)"
	replace Jetonlisteprincipale="95" if Jetonlisteprincipale=="095 (19)"
	replace Jetonlisteprincipale="91" if Jetonlisteprincipale=="091 (10)"
	replace Jetonlisteprincipale="104" if Jetonlisteprincipale=="104 (14)"
	replace Jetonlisteprincipale="24" if Jetonlisteprincipale=="024 (9)"
	replace Jetonlisteprincipale="64" if Jetonlisteprincipale=="064 (22)"
	replace Jetonlisteprincipale="12" if Jetonlisteprincipale=="012 (4)"
	replace Jetonlisteprincipale="57" if Jetonlisteprincipale=="057 (5)"
	replace Jetonlisteprincipale="48" if Jetonlisteprincipale=="048 (2)"
	replace Jetonlisteprincipale="133" if Jetonlisteprincipale=="133 (23)"
	replace Jetonlisteprincipale="103" if Jetonlisteprincipale=="103 (15)"
	replace Jetonlisteprincipale="76" if Jetonlisteprincipale=="076 (3)"
	replace Jetonlisteprincipale="63" if Jetonlisteprincipale=="063 (21)"
	replace Jetonlisteprincipale="30" if Jetonlisteprincipale=="030 (24)"
	replace Jetonlisteprincipale="120" if Jetonlisteprincipale=="120 (12)"
	replace Jetonlisteprincipale="105" if Jetonlisteprincipale=="105 (20)"
	replace Jetonlisteprincipale="21" if Jetonlisteprincipale=="021 (4)"
	replace Jetonlisteprincipale="18" if Jetonlisteprincipale=="018 (1)"
	replace Jetonlisteprincipale="11" if Jetonlisteprincipale=="011 (2)"
	replace Jetonlisteprincipale="7" if Jetonlisteprincipale=="007 (3)"
	replace Jetonlisteprincipale="8" if Jetonlisteprincipale=="8(2)"
	replace Jetonlisteprincipale="7" if Jetonlisteprincipale=="7(3)"
	replace Jetonlisteprincipale="9" if Jetonlisteprincipale=="9(1)"
	replace Jetonlisteprincipale="10" if Jetonlisteprincipale=="10(4)"
	replace Jetonlisteprincipale="3" if Jetonlisteprincipale=="003(06)"
	replace Jetonlisteprincipale="177" if Jetonlisteprincipale=="177(35)"
	replace Jetonlisteprincipale="61" if Jetonlisteprincipale=="061(32)"
	replace Jetonlisteprincipale="15" if Jetonlisteprincipale=="015(20)"
	replace Jetonlisteprincipale="198" if Jetonlisteprincipale=="198(36)"
	replace Jetonlisteprincipale="202" if Jetonlisteprincipale=="202(9)"
	replace Jetonlisteprincipale="84" if Jetonlisteprincipale=="084(16)"
	replace Jetonlisteprincipale="156" if Jetonlisteprincipale=="156(14)"
	replace Jetonlisteprincipale="208" if Jetonlisteprincipale=="208"
	replace Jetonlisteprincipale="70" if Jetonlisteprincipale=="070(37)"
	replace Jetonlisteprincipale="68" if Jetonlisteprincipale=="068(8)"
	replace Jetonlisteprincipale="53" if Jetonlisteprincipale=="053(22)"
	replace Jetonlisteprincipale="47" if Jetonlisteprincipale=="047(13)"
	replace Jetonlisteprincipale="30" if Jetonlisteprincipale=="030(5)"
	replace Jetonlisteprincipale="204" if Jetonlisteprincipale=="204"
	replace Jetonlisteprincipale="206" if Jetonlisteprincipale=="206"
	replace Jetonlisteprincipale="52" if Jetonlisteprincipale=="052(10)"
	replace Jetonlisteprincipale="11" if Jetonlisteprincipale=="011(25)"
	replace Jetonlisteprincipale="28" if Jetonlisteprincipale=="028(2)"
	replace Jetonlisteprincipale="136" if Jetonlisteprincipale=="136(31)"
	replace Jetonlisteprincipale="203" if Jetonlisteprincipale=="203"
	replace Jetonlisteprincipale="35" if Jetonlisteprincipale=="035(40"
	replace Jetonlisteprincipale="175" if Jetonlisteprincipale=="175(7)"
	replace Jetonlisteprincipale="2" if Jetonlisteprincipale=="002(26)"
	replace Jetonlisteprincipale="45" if Jetonlisteprincipale=="045(30)"
	replace Jetonlisteprincipale="55" if Jetonlisteprincipale=="055(19)"
	replace Jetonlisteprincipale="173" if Jetonlisteprincipale=="173(28)"
	replace Jetonlisteprincipale="22" if Jetonlisteprincipale=="022(33)"
	replace Jetonlisteprincipale="90" if Jetonlisteprincipale=="090(29)"
	replace Jetonlisteprincipale="25" if Jetonlisteprincipale=="025(18)"
	replace Jetonlisteprincipale="6" if Jetonlisteprincipale=="006(24)"
	replace Jetonlisteprincipale="64" if Jetonlisteprincipale=="064(11)"
	replace Jetonlisteprincipale="71" if Jetonlisteprincipale=="071(38)"
	replace Jetonlisteprincipale="50" if Jetonlisteprincipale=="050(15)"
	replace Jetonlisteprincipale="190" if Jetonlisteprincipale=="190(21)"
	replace Jetonlisteprincipale="26" if Jetonlisteprincipale=="026(12)"
	replace Jetonlisteprincipale="19" if Jetonlisteprincipale=="019(1)"
	replace Jetonlisteprincipale="36" if Jetonlisteprincipale=="036(34)"
	replace Jetonlisteprincipale="40" if Jetonlisteprincipale=="040 (7)"
	replace Jetonlisteprincipale="85" if Jetonlisteprincipale=="085 (9)"
	replace Jetonlisteprincipale="29" if Jetonlisteprincipale=="029 (5)"
	replace Jetonlisteprincipale="21" if Jetonlisteprincipale=="021 (18)"
	replace Jetonlisteprincipale="1" if Jetonlisteprincipale=="001 (11)"
	replace Jetonlisteprincipale="10" if Jetonlisteprincipale=="010 (6)"
	replace Jetonlisteprincipale="77" if Jetonlisteprincipale=="077 (2)"
	replace Jetonlisteprincipale="30" if Jetonlisteprincipale=="030 (12)"
	replace Jetonlisteprincipale="84" if Jetonlisteprincipale=="084 (3)"
	replace Jetonlisteprincipale="26" if Jetonlisteprincipale=="026 (15)"
	replace Jetonlisteprincipale="33" if Jetonlisteprincipale=="033 (1)"
	replace Jetonlisteprincipale="2" if Jetonlisteprincipale=="002 (13)"
	replace Jetonlisteprincipale="96" if Jetonlisteprincipale=="096 (10)"
	replace Jetonlisteprincipale="39" if Jetonlisteprincipale=="039 (17)"
	replace Jetonlisteprincipale="57" if Jetonlisteprincipale=="057 (8)"
	replace Jetonlisteprincipale="66" if Jetonlisteprincipale=="066 (16)"
	replace Jetonlisteprincipale="58" if Jetonlisteprincipale=="058 (14)"
	replace Jetonlisteprincipale="4" if Jetonlisteprincipale=="004 (4)"
	replace Jetonlisteprincipale="28" if Jetonlisteprincipale=="028(2)"
	replace Jetonlisteprincipale="13" if Jetonlisteprincipale=="013(1)"
	replace Jetonlisteprincipale="34" if Jetonlisteprincipale=="034(7)"
	replace Jetonlisteprincipale="37" if Jetonlisteprincipale=="037(4)"
	replace Jetonlisteprincipale="29" if Jetonlisteprincipale=="029(8)"
	replace Jetonlisteprincipale="123" if Jetonlisteprincipale=="123(1)"
	replace Jetonlisteprincipale="98" if Jetonlisteprincipale=="098(12)"
	replace Jetonlisteprincipale="79" if Jetonlisteprincipale=="079(3)"
	replace Jetonlisteprincipale="104" if Jetonlisteprincipale=="104(7)"
	replace Jetonlisteprincipale="15" if Jetonlisteprincipale=="015(10)"
	replace Jetonlisteprincipale="112" if Jetonlisteprincipale=="112(11)"
	replace Jetonlisteprincipale="78" if Jetonlisteprincipale=="078(3)"
	replace Jetonlisteprincipale="124" if Jetonlisteprincipale=="124(9)"
	replace Jetonlisteprincipale="54" if Jetonlisteprincipale=="054(5)"
	replace Jetonlisteprincipale="39" if Jetonlisteprincipale=="039(8)"
	replace Jetonlisteprincipale="35" if Jetonlisteprincipale=="035(10)"
	replace Jetonlisteprincipale="25" if Jetonlisteprincipale=="025(5)"
	replace Jetonlisteprincipale="75" if Jetonlisteprincipale=="075(2)"
	replace Jetonlisteprincipale="95" if Jetonlisteprincipale=="095(11)"
	replace Jetonlisteprincipale="5" if Jetonlisteprincipale=="005(9)"
	replace Jetonlisteprincipale="87" if Jetonlisteprincipale=="087(6)"
	replace Jetonlisteprincipale="85" if Jetonlisteprincipale=="085(4)"
	replace Jetonlisteprincipale="12" if Jetonlisteprincipale=="012(6)"
	replace Jetonlisteprincipale="3" if Jetonlisteprincipale=="003 (1)"


	
	egen nomdupliques=concat(village noms age gender phone duration_2 key),punct(" ")
	order nomdupliques village noms age gender phone duration_2 key
	duplicates tag noms, gen(dupnom)
	drop if dupnom==1 & village=="Libabi"
	duplicates tag noms, gen(dupnoms)

	
	export excel using "C:\Users\LENOVO\Desktop\duplicates_noms.xlsx", replace firstrow(variables)
	
	rename _merge mergeavant
	
	*qui do "$do/Codebook.do"
	merge m:1 village using "$data/01. Dataset/03_final/villagethimoruraux.dta"
	tab _merge 
	generate monimerge=_merge
	drop if monimerge==2
		drop jeton1	jeton2
	
	replace village_variante_orig=village_variante if village_variante_orig==.
	ren Village villageold
	
	drop village_codde village_id vid troncon troncons IDV Roadsection monimerge bassin province
	
	generate IDV=vuid
	rename provinced province
	drop vuid
	replace Jetonlistederéserve=. if Jetonlistederéserve==0
	destring JetonlistePrincipale, replace
	destring Jetonlisteprincipale, replace
	destring Jetonlistesecondaire, replace
	
	replace JetonlistePrincipale=. if JetonlistePrincipale==0
	replace Jetonlisteprincipale=. if Jetonlisteprincipale==0
	replace Jetonlistesecondaire=. if Jetonlistesecondaire==0
	
	replace jeton=Jetonlistederéserve if jeton==.
	replace jeton=JetonlistePrincipale if jeton==.
	replace jeton=Jetonlisteprincipale if jeton==.
	replace jeton=Jetonlistesecondaire if jeton==.
	
	replace hhid_nouveau=hhid_nouveau1 if hhid_nouveau==.
	replace hhid_nouveau=hhid_nouveau2 if hhid_nouveau==.
	destring hhid_nouveau3 hhid_nouveau4 hhid_nouveau5, replace
	replace hhid_nouveau=hhid_nouveau3 if hhid_nouveau==.
	replace hhid_nouveau=hhid_nouveau4 if hhid_nouveau==.
	replace hhid_nouveau=hhid_nouveau5 if hhid_nouveau==.
	replace hhid=hhid_nouveau if hhid==.
	
	replace gender=0 if key=="uuid:67c99a9a-ba2b-482c-bbc5-1eba435e5255"
	replace gender=0 if key=="uuid:9958d318-348d-41b7-9618-2e5dd977e10d"
	replace gender=0 if key=="uuid:8d7d8a84-d3a9-4f0e-92b5-bf3faf81f537"
	replace gender=0 if key=="uuid:867ceb15-c2bb-445f-bc13-28b1edf875d5"
	replace gender=0 if key=="uuid:73ce6991-25b6-4b09-8828-a03880307e3b"
	replace gender=0 if key=="uuid:c9853423-393b-476f-a638-a21803f7f601"
	replace gender=0 if key=="uuid:751b9572-4f2d-461b-b19b-80ea3286f4c1"
	replace gender=0 if key=="uuid:b37ddda3-9fd8-4f9b-9677-23236989964b"
	replace gender=0 if key=="uuid:47638e5a-410a-4f0e-9255-b88d006e564a"

	replace Nomcomplet=nomcomplet if Nomcomplet==""
	
	*replace etatcivil =marital_status if etatcivil==""

	rename nom nomfrompreload
	rename noms Noms
	replace gpsaccuracy=gpsAccuracy if gpsaccuracy==""
	drop if Nomcomplet=="AKUMU KAWAMBE EMMANUELLA" & key=="uuid:d9469706-e788-4756-bd18-c02f3decf3c1"

	drop Jetonlistederéserve JetonlistePrincipale Jetonlisteprincipale Jetonlistesecondaire hhid_nouveau* hhid_confirm hhid_key hhidold hhkey nomcomplet benef_last_name  ///
	benef_name	benef_names	benef_nams	benef_post_name Gender genre KEY keyphase1 nomcomplet confirm_village_codde deviceid devicephonenum enumerator_codde enumerator_id  ///
	equipe	formdef_version gpsAccuracy gr_id group groupe grouper grouperespondent grouperespondent_id	grouping marital_status listing listing_2 listing_3 member_nam  ///
	member_nam_1 member_nam_10 member_nam_2 member_nam_3 member_nam_4 member_nam_5 member_nam_6 member_nam_7 member_nam_8 member_nam_9 worker_age poiddouble poids  ///
	poids_def poids_def1 poids1 simid subscriberid Villagenew villagetype worker_id	workerid status	statut C candid candidats commentaires Commentaires elegible_baseline_female  ///
	elegible_baseline_male elegible_surveyed_female elegible_surveyed_male endtime J mergeavant mergold mergp1p2 miss_coord N population registered_female  ///
	registered_male	registration_phase	registred_personn_count _merge	_merged	append_1 base1 base2 base3 base4 base5 base6 P1 P10 P11 P12 P13 P14 P15  ///
	P16 P17 P18 P19 P2 P20 P21 P22 P23 P3 P4 P5 P6 P7 P8 P9 Totalcandidats worker_eligible duratio_0 duration duration_21 duration_22 duration_i date  ///
	dic_vill underscore	unique_id unique_ID	nomdupliques



	order province  provinced_id territoired corridor corridord corridord_id roadsectiond roadsectiond_id assigned_ale_organization  ///
	IDV village village_variante village_variante_orig jeton hhid key Nomcomplet Noms gender carte_elect phone adresse age etatcivil  ///
	depla_refug ex_combatant hh_occupa autre_occup hh_occupa_temp hh_occupa1 hh_occupation land_possess land_possess_ha land_used land_used_ha lieu_culte lire_ecrire incomsize  ///
	parente respondent_hhheadrelated retourne prof profession worker_occupation religion reference_adresse reference_personne reference_phone Passer_journee_sansmanger  ///
	dupnom dupnoms duration_2 groupes ch_com_selec_rank chief_selection_rank loterierank loto order_replacement_ctrl  ///
	rang rang_randomisation rangement Ranglisteréserve Rangloteriereserve Rangloterieseulementpourla Ranglotterieseulementpourla Rangsélectionparlechef Rangsélectionparlecomité  ///
	rank replacementlist replacementrank selected_treated_control_female selected_treated_control_male selectedpeople_treated_female selectedpeople_treated_male Sélection  ///
	selection_method selection_methodcode selection_statut selectionned selectionstatut statut2_surv statut3_selec statutselection strat treatement treatement_old  ///
	treatmen treatment wanted buy_bovins buy_caprins buy_lapins buy_others buy_plantations buy_porcins buy_volaille consent conso_limit_variete  ///
	conso_nopref_alim decline Emprunter_nourriture enddate enumerator gpsaccuracy gpsaltitude gpslatitude gpslongitude implementation_status jourconsom_Cereales jourconsom_Chasse_Ceuillette  ///
	jourconsom_Fruits jourconsom_Legumineuses jourconsom_Marins jourconsom_Œufs jourconsom_Produit_laitiers jourconsom_Tubercules jourconsom_Vegetaux_Feuille jourconsom_Viande_betail  ///
	jourconsom_Viande_volaille langue length_km member_names multi_semence nb_armoir nb_arrosoir nb_autre1 nb_autre2 nb_batterie_solaire  ///
	nb_batteuse nb_biblio nb_bovins nb_buy_bovins nb_buy_caprins nb_buy_lapins nb_buy_others nb_buy_plantations nb_buy_porcins nb_buy_volaille nb_caprins nb_cellulaire nb_chaise_banc  ///
	nb_chariot nb_charrue nb_climatiseur nb_cuisiniere_gaz nb_decodeur nb_faucille nb_fauteuils_table nb_fer_charbon nb_fer_electrique nb_fourneau nb_frigo nb_groupe_electro nb_hache  ///
	nb_hache_paille nb_houe nb_lampe_gaz nb_lampe_petrole nb_lampe_poche nb_lampe_solaire nb_lapins nb_lit_bois_metal nb_machette nb_machine_coudre nb_magnetoscope nb_matelas nb_moto  ///
	nb_moulin_tradi nb_natte nb_other3 nb_pelle nb_pioche nb_placard nb_plantations nb_plaque_solaire nb_pompe_manuelle nb_pompe_motorisee nb_porcins nb_pulverisateur nb_radio  ///
	nb_rateau nb_rechaud nb_sell_bovins nb_sell_caprins nb_sell_lapins nb_sell_others nb_sell_plantations nb_sell_porcins nb_sell_volaille nb_semoir nb_table nb_tablette  ///
	nb_telephone nb_television nb_tracteur nb_velo nb_ventilateur nb_voiture nb_volaille nombre nombre_4 nombre_6 Nombrepersonnesclassées number_repas_adultes number_repas_enfants  ///
	numberhh Observations observations othermember own_armoir own_arrosoir own_autre1 own_autre1x own_autre2 own_autre2x own_autre3 own_autre3x own_batterie_solaire  ///
	own_batteuse own_bibliotheque own_bovins own_caprins own_cellulaire own_chaise_banc own_chariot own_charrue own_climatiseur own_cuisiniere_gaz own_decodeur  ///
	own_faucille own_fauteuils_table own_fer_charbon own_fer_electrique own_fourneau own_frigo own_groupe_electro own_hache own_hache_paille own_houe own_lampe_gaz  ///
	own_lampe_petrole own_lampe_poche own_lampe_solaire own_lapins own_lecteur_dvd own_lit_bois_metal own_machette own_machine_coudre own_matelas own_moto own_moulin_tradi  ///
	own_natte own_pelle own_pioche own_placard own_plantations own_plaque_solaire own_pompe_manuelle own_pompe_motorisee own_porcins own_pulverisateur own_radio own_rateau  ///
	own_rechaud own_semoir own_table own_tablette own_telephone_fixe own_television own_tracteur own_velo own_ventilateur own_voiture own_volaille Reduire_nombrerepas  ///
	Reduire_quantite Reduire_quantiteadultes revenu_prin_part revenu_princ s2_2_list_4 s2_2_num_4 s2_3_list_7 s2_3_list_8 s2_3_num_6 s2_3_num_7 s3_1_10 s3_1_11 s3_3_num_1  ///
	s3_3_num_2 s3_3_num_3 s3_3_num_4 s3_3_num_5 s3_3_num_6 s3_3_num_7 s4_3_num_1 s4_3_num_2 s4_3_num_3 s4_3_num_4 s4_3_num_5 s4_3_num_6 s4_3_num_7 s5_3_num_1 s5_3_num_2  ///
	s5_3_num_3 s5_3_num_4 s5_3_num_5 s5_3_num_6 s5_3_num_7 s6_3_num_1 s6_3_num_2 s6_3_num_3 s6_3_num_4 s6_3_num_5 s6_3_num_6 s6_3_num_7 sell_bovins sell_caprins sell_lapins  ///
	sell_others sell_plantations sell_porcins sell_volaille stress_food auto_pygm photo startdate starttime submissiondate surveyorname travailleur unitesuperficie1 unitesuperficie2 watersource watersource_autre

	dropmiss, force
	export excel using "C:\Users\LENOVO\Desktop\organisation_variabl.xlsx", replace firstrow(variables)
	save "$data/01. Dataset/03_final/THIMOR2018_merge.dta", replace
	
	/*preserve 
	keep troncon troncons vid village Village village_codde village_id village_variante village_variante_orig Villagenew villagetype wanted  ///
	nom	nomcomplet Nomcomplet noms benef_last_name benef_name benef_names benef_nams benef_post_name age adresse religion marital_status etatcivil  ///
	gender Gender genre prof profession hhid hhid_confirm hhid_key hhidold hhkey IDV key KEY lieu_culte loterierank loto  ///
	ch_com_selec_rank chief_selection_rank rang rang_randomisation rangement Ranglisteréserve Rangloteriereserve  ///
	Rangloterieseulementpourla Ranglotterieseulementpourla Rangsélectionparlechef Rangsélectionparlecomité rank  ///
	replacementlist replacementrank Sélection selection_statut selectionned selectionstatut status statut statut2_surv  ///
	statut3_selec statutselection strat treatement treatement_old treatmen treatment groupes

	export excel using "C:\Users\LENOVO\Desktop\traitementes.xlsx", replace firstrow(variables)
	restore
	
	
	
	
