use "C:\Users\avet\Desktop\Mariana\ALL_Results_20211010\10_S4_S5_LS_farm_ls_categories_movements․dta.dta", clear
// gen III_a = 4 if iii_a=="Armavir"
// replace III_a = 7 if iii_a=="Kotayk"
// replace III_a = 8 if iii_a=="Shirak"
// replace III_a = 11 if iii_a=="Tavush"

keep if livestock_code==1 | livestock_code==11 | livestock_code==13 | livestock_code==15 | livestock_code==20 

levelsof livestock_code
local categ  = r(levels)

// drop if Qtity==0 | Qtity==.

levelsof III_a
local marz=r(levels)

levelsof legal_status
local ls = r(levels)

foreach l in `ls'{
	foreach i in `marz' {

	levelsof livestock_code if III_a== `i' & legal_status==`l'
	local present_`i' = r(levels) 
	local missing_`i' : list categ - present_`i' 



		foreach id in `missing_`i''{
			if `id'>0{
					set obs `=_N+1'
				replace livestock_code =`id' if _n==_N
				replace III_a=`i' if _n==_N
				replace w_all_hij_ann = 1  if _n==_N
				replace legal_status = `l' if _n==_N
			}
		}
	}
}	


gen sl_f1  = slaught_f_1 * w_all_hij_ann
gen s1_sh1 =  slaught_sh_1 * w_all_hij_ann
gen sld_1  = sold_1 * w_all_hij_ann
gen val1 = (value_1 * w_all_hij_ann)/1000


mvencode sl_f1 s1_sh1 sld_1 val1 , mv(0) override


gen nh1_1 = w_all_hij_ann if sl_f1!= 0
gen nh1_2 = w_all_hij_ann if s1_sh1!= 0
gen nh1_3 = w_all_hij_ann if sld_1!= 0

mvencode nh1_1  nh1_2 nh1_3 , mv(0)

tabstat  nh1_1 sl_f1 nh1_2 s1_sh1 nh1_3 sld_1 val1 if III_a == 4 & legal_status==1 , s(sum) by( livestock_code) save
matrix A1 = (r(Stat1) \ r(Stat2) \ r(Stat3) \ r(Stat4) \ r(Stat5))
 
tabstat  nh1_1 sl_f1 nh1_2 s1_sh1 nh1_3 sld_1 val1 if III_a == 4 & legal_status==2 ,  s(sum) by( livestock_code) save
matrix A2 = (r(Stat1) \ r(Stat2) \ r(Stat3) \ r(Stat4) \ r(Stat5))


tabstat  nh1_1 sl_f1 nh1_2 s1_sh1 nh1_3 sld_1 val1 if III_a == 7 & legal_status==1 , s(sum) by( livestock_code) save 
matrix K1 = (r(Stat1) \ r(Stat2) \ r(Stat3) \ r(Stat4) \ r(Stat5))

tabstat  nh1_1 sl_f1 nh1_2 s1_sh1 nh1_3 sld_1 val1 if III_a == 7 & legal_status==2 ,  s(sum) by( livestock_code) save
matrix K2 = (r(Stat1) \ r(Stat2) \ r(Stat3) \ r(Stat4) \ r(Stat5))
 
 
 
tabstat  nh1_1 sl_f1 nh1_2 s1_sh1 nh1_3 sld_1 val1 if III_a == 8 & legal_status==1 , s(sum) by( livestock_code) save 
matrix Sh1 = (r(Stat1) \ r(Stat2) \ r(Stat3) \ r(Stat4) \ r(Stat5))

tabstat  nh1_1 sl_f1 nh1_2 s1_sh1 nh1_3 sld_1 val1 if III_a == 8 & legal_status==2 ,  s(sum) by( livestock_code ) save
matrix Sh2 = (r(Stat1) \ r(Stat2) \ r(Stat3) \ r(Stat4) \ r(Stat5))


tabstat  nh1_1 sl_f1 nh1_2 s1_sh1 nh1_3 sld_1 val1 if III_a == 11 & legal_status==1 , s(sum) by( livestock_code) save 
matrix T1 = (r(Stat1) \ r(Stat2) \ r(Stat3) \ r(Stat4) \ r(Stat5))


tabstat  nh1_1 sl_f1 nh1_2 s1_sh1 nh1_3 sld_1 val1 if III_a == 11 & legal_status==2 ,  s(sum) by( livestock_code)save
matrix T2 = (r(Stat1) \ r(Stat2) \ r(Stat3) \ r(Stat4) \ r(Stat5))



putexcel set C:\Users\avet\Documents\Final_tables, sheet(Animal_slaughtered) modify

putexcel (F14) = matrix(A1)
putexcel (F21) = matrix(A2)

putexcel (F27) = matrix(K1)
putexcel (F34) = matrix(K2)

putexcel (F40) = matrix(Sh1)
putexcel (F47) = matrix(Sh2)

putexcel (F53) = matrix(T1)
putexcel (F60) = matrix(T2)

mat drop _all
								gen sl_f2  = slaught_f_2 * w_all_hij_ann
								gen sl_sh2 =  slaught_sh_2 * w_all_hij_ann
								gen sld_2  = sold_2 * w_all_hij_ann
								gen val2 = (value_2 * w_all_hij_ann)/1000


								mvencode sl_f2 sl_sh2 sld_2 val2 , mv(0) override


								gen nh2_1 = w_all_hij_ann if sl_f2!= 0
								gen nh2_2 = w_all_hij_ann if sl_sh2!= 0
								gen nh2_3 = w_all_hij_ann if sld_2!= 0

								mvencode nh2_1  nh2_2 nh2_3 , mv(0)

								tabstat  nh2_1 sl_f2 nh2_2 sl_sh2 nh2_3 sld_2 val2 if III_a == 4 & legal_status==1 , s(sum) by( livestock_code) save
								matrix A1 = (r(Stat1) \ r(Stat2) \ r(Stat3) \ r(Stat4) \ r(Stat5))
								 
								tabstat  nh2_1 sl_f2 nh2_2 sl_sh2 nh2_3 sld_2 val2 if III_a == 4 & legal_status==2 ,  s(sum) by( livestock_code) save
								matrix A2 = (r(Stat1) \ r(Stat2) \ r(Stat3) \ r(Stat4) \ r(Stat5))


								tabstat  nh2_1 sl_f2 nh2_2 sl_sh2 nh2_3 sld_2 val2 if III_a == 7 & legal_status==1 , s(sum) by( livestock_code) save 
								matrix K1 = (r(Stat1) \ r(Stat2) \ r(Stat3) \ r(Stat4) \ r(Stat5))

								tabstat  nh2_1 sl_f2 nh2_2 sl_sh2 nh2_3 sld_2 val2 if III_a == 7 & legal_status==2 ,  s(sum) by( livestock_code) save
								matrix K2 = (r(Stat1) \ r(Stat2) \ r(Stat3) \ r(Stat4) \ r(Stat5))
								 
								 
								 
								tabstat  nh2_1 sl_f2 nh2_2 sl_sh2 nh2_3 sld_2 val2 if III_a == 8 & legal_status==1 , s(sum) by( livestock_code) save 
								matrix Sh1 = (r(Stat1) \ r(Stat2) \ r(Stat3) \ r(Stat4) \ r(Stat5))

								tabstat  nh2_1 sl_f2 nh2_2 sl_sh2 nh2_3 sld_2 val2 if III_a == 8 & legal_status==2 ,  s(sum) by( livestock_code ) save
								matrix Sh2 = (r(Stat1) \ r(Stat2) \ r(Stat3) \ r(Stat4) \ r(Stat5))


								tabstat  nh2_1 sl_f2 nh2_2 sl_sh2 nh2_3 sld_2 val2 if III_a == 11 & legal_status==1 , s(sum) by( livestock_code) save 
								matrix T1 = (r(Stat1) \ r(Stat2) \ r(Stat3) \ r(Stat4) \ r(Stat5))


								tabstat  nh2_1 sl_f2 nh2_2 sl_sh2 nh2_3 sld_2 val2 if III_a == 11 & legal_status==2 ,  s(sum) by( livestock_code)save
								matrix T2 = (r(Stat1) \ r(Stat2) \ r(Stat3) \ r(Stat4) \ r(Stat5))
								
								
								putexcel set C:\Users\avet\Documents\Final_tables, sheet(Animal_slaughtered) modify

								putexcel (Y14) = matrix(A1)
								putexcel (Y21) = matrix(A2)

								putexcel (Y27) = matrix(K1)
								putexcel (Y34) = matrix(K2)

								putexcel (Y40) = matrix(Sh1)
								putexcel (Y47) = matrix(Sh2)

								putexcel (Y53) = matrix(T1)
								putexcel (Y60) = matrix(T2)



								
								