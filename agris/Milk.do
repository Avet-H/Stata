use "C:\Users\avet\Desktop\Mariana\ALL_Results_20211010\11_S5_S6_MILK_farm_milk_type_prod&use.dta", clear
// gen milk = 1 if milk_id=="Milk from cows"
// replace  milk = 2 if milk_id=="Milk from buffaloes"
// replace  milk = 3 if milk_id=="Milk from goats"
// replace  milk = 4 if milk_id=="Milk from sheep"

			levelsof milk
			local categ  = r(levels)

			levelsof III_a
			local marz=r(levels)

			levelsof legal_status
			local ls = r(levels)

			foreach l in `ls'{
				foreach i in `marz' {

				levelsof milk if III_a== `i' & legal_status==`l'
				local present_`i' = r(levels) 
				local missing_`i' : list categ - present_`i' 

					foreach id in `missing_`i''{
						if `id'>0{
								set obs `=_N+1'
							replace milk =`id' if _n==_N
							replace III_a=`i' if _n==_N
							replace w_all_hij_ann = 1  if _n==_N
							replace legal_status = `l' if _n==_N
						}
					}
				}
			}	


// apply weights 
gen Q1 = (s5q2_a+ s5q2_b+ s5q2_c)* w_all_hij_ann
gen Q2 = (s5q2_d+ s5q2_e+ s5q2_f)* w_all_hij_ann
gen Q3 = (s6q2_a+ s6q2_b+ s6q2_c)* w_all_hij_ann
gen Q4 = (s6q2_d+ s6q2_e+ s6q2_f)* w_all_hij_ann

mvencode  Q1  Q2  Q3  Q4 , mv(0) override


gen nh_Q1 =  w_all_hij_ann if Q1!=0
gen nh_Q2 =  w_all_hij_ann if Q2!=0
gen nh_Q3 =  w_all_hij_ann if Q3!=0
gen nh_Q4 =  w_all_hij_ann if Q4!=0

mvencode nh_Q1  nh_Q2 nh_Q3  nh_Q4  , mv(0) override


tabstat  nh_Q1 Q1  nh_Q2 Q2  nh_Q3 Q3  nh_Q4  Q4 if III_a == 4 & legal_status==1 , s(sum) by( milk) save
matrix A1 = (r(Stat1) \ r(Stat2) \ r(Stat3) \ r(Stat4) )
 
tabstat  nh_Q1 Q1  nh_Q2 Q2  nh_Q3 Q3  nh_Q4  Q4 if III_a == 4 & legal_status==2 ,  s(sum) by( milk) save
matrix A2 = (r(Stat1) \ r(Stat2) \ r(Stat3) \ r(Stat4) )


tabstat  nh_Q1 Q1  nh_Q2 Q2  nh_Q3 Q3  nh_Q4  Q4 if III_a == 7 & legal_status==1 , s(sum) by( milk) save 
matrix K1 = (r(Stat1) \ r(Stat2) \ r(Stat3) \ r(Stat4) )

tabstat  nh_Q1 Q1  nh_Q2 Q2  nh_Q3 Q3  nh_Q4  Q4 if III_a == 7 & legal_status==2 ,  s(sum) by( milk) save
matrix K2 = (r(Stat1) \ r(Stat2) \ r(Stat3) \ r(Stat4) )
 
 
 
tabstat  nh_Q1 Q1  nh_Q2 Q2  nh_Q3 Q3  nh_Q4  Q4 if III_a == 8 & legal_status==1 , s(sum) by( milk) save 
matrix Sh1 = (r(Stat1) \ r(Stat2) \ r(Stat3) \ r(Stat4) )

tabstat  nh_Q1 Q1  nh_Q2 Q2  nh_Q3 Q3  nh_Q4  Q4 if III_a == 8 & legal_status==2 ,  s(sum) by( milk ) save
matrix Sh2 = (r(Stat1) \ r(Stat2) \ r(Stat3) \ r(Stat4) )


tabstat  nh_Q1 Q1  nh_Q2 Q2  nh_Q3 Q3  nh_Q4  Q4 if III_a == 11 & legal_status==1 , s(sum) by( milk) save 
matrix T1 = (r(Stat1) \ r(Stat2) \ r(Stat3) \ r(Stat4) )


tabstat  nh_Q1 Q1  nh_Q2 Q2  nh_Q3 Q3  nh_Q4  Q4 if III_a == 11 & legal_status==2 ,  s(sum) by( milk)save
matrix T2 = (r(Stat1) \ r(Stat2) \ r(Stat3) \ r(Stat4) )



putexcel set C:\Users\avet\Documents\Final_tables, sheet(Milk) modify

putexcel (F9) = matrix(A1)
putexcel (F14) = matrix(A2)

putexcel (F19) = matrix(K1)
putexcel (F24) = matrix(K2)

putexcel (F29) = matrix(Sh1)
putexcel (F34) = matrix(Sh2)

putexcel (F39) = matrix(T1)
putexcel (F44) = matrix(T2)

mat drop _all




















