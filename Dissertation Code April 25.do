/* 
Draft 1 Coding for Dissertation 

Empirical Strategy 

1. Gather data 

2. Clean data
 
3. Create 0/1 assignment from logit regression for each firm which identifies strategy 
	0 - firms with `offensive strategy' = `new area' + `high quant' + `low citations' 
	1 - firms with `strategic' = `same area' - `low quant' + `low citations' 

4. Create your competition variable for each firm 
		Competition: The lerner index is more difficult to calculate, and would require a massive dataset. Instead, I would like to use market share (a suggested alternative). This will be done using the Compustat Financials data set 

5. Create your innovation variable for each firm
	Innovation / Citation-weighted technology patents: In the data I listed,  g_us_patent_citation and  g_foreign_citation, would be used to calculate the number of citations that have been given to each patent, then using g_assignee_disambiguated we can assign these patents to their firms.  

6. Create the year fixed effects 

7. Create the policy fixed effects 

8. Create technology gap 
	gap: while a high value of mjt indicates a large technological gap with the frontier (so that firms in those industries are more like laggard firms in an unleveled industry). Where m is the firm's average TFP.


*/

/* g_patent.dta"

 tab patent_type

patent_type |      Freq.     Percent        Cum.
------------+-----------------------------------
       TVPP |          3        0.00        0.00
     design |         15        0.00        0.00
      plant |          1        0.00        0.00
    reissue |         49        0.00        0.00
    utility |  5,791,245      100.00      100.00
------------+-----------------------------------
      Total |  5,791,313      100.00
	  
Clean 1: 
. drop if withdrawn==1
(9,130 observations deleted)

. drop if patent_type =="plant"
(1 observation deleted)

. drop if  wipo_kind =="E"
(49 observations deleted)

. 
. drop if patent_type =="TVPP"
(3 observations deleted)

. drop if patent_type =="design" 
(15 observations deleted)

. drop if  wipo_kind =="I5"
(0 observations deleted)

. drop if  wipo_kind =="P"
(0 observations deleted)

. drop if  wipo_kind =="S"
(0 observations deleted)


. gen datevar = date(patent_date, "YMD")
(2 missing values generated)

drop if patent_date < "2000-01-01"

. tab patent_type

patent_type |      Freq.     Percent        Cum.
------------+-----------------------------------
    utility |  3,715,105      100.00      100.00
------------+-----------------------------------
      Total |  3,715,105      100.00

*/ 

/* g_us_patent_citation.dta"

drop if  wipo_kind =="C1"
drop if  wipo_kind =="C2"
drop if  wipo_kind =="C3"
drop if  wipo_kind =="E1"
drop if  wipo_kind =="H"
drop if  wipo_kind =="P1"
drop if  wipo_kind =="P2"
drop if  wipo_kind =="P3"
drop if  wipo_kind =="U"
drop if  wipo_kind =="U1"




*/ 

/* g_foreign_citation


gen datevar = date(citation_date, "YMD")

drop if citation_date < "2000-01-01"



*/

/* /g_cpc_current.dta



drop cpc_symbol_position

cpc section (A = Human Necessitates, B = Performing Operations; Transporting, C = Chemistry; Metallurgy, D = Textiles; Paper, E = Fixed Constructions, F = Mechanical Engineering; Lighting; Heating; Weapons; Blasting Engines or Pumps, G = Physics, H = Electricity, Y = General Tagging of New Technological Developments)

*/

/* /g_assignee_disambiguated.dta"


*/

/* /g_assignee_disambiguated.dta"

gen datevar = date(filing_date, "YMD")

drop if filing_date < "1998-01-01"
. drop datevar rule_47_flag filing_date

*/

/* 

The most general cleanings are now done. 

I can focus on merging and creating new variables. 

Once he new variables are creaed, I intend to delee the old variables for he 
sake of memory and storage. 


*/ 

clear 


* Starting with g_patent data instead 
* SO i'll have to go back and add the big fucker... or create the variables I need in the big one and then export only the needed variables ? 

destring patent_id, force replace
drop if missing(patent_id)

* merged patent_g and g_assignee_disambiguated


merge m:1 patent_id using 


*save "/Users/tsagedouglas/Desktop/Thesis - Sorb/Diss Data/_merged.dta", replace


/* 

Creating strategy.dta 

1. for patent_area: 
merged -merged.dta and g-cpc-current 
based on patent-id, disambig_assignee_organization, and cpc_section


bysort disambig_assignee_organization cpc_section: gen patent_area = cond(_N == _N[_n], 1, 0)

rename to patent_area w label 1 = same are, 0 - different area 

drop cpc_section 

2. merge in g_us_patent_citation 
keep citation_patent_id, merged in paent_id 

sum citation_patent_id by disambig_org (assign the sam # to all orgs with thee same name). Them sum citation_app_id by disambig_org () . Then add the two together in one column. 

2. To create the varaible patents, use patent_id and dissambig_org () 

How many datapoints do we have now? `40 m? 

Rename any columns as needed, 

then create the strategy varaible. 

6. Strategy 

If '
*/ 
