use "C:\Users\avet\Desktop\Mariana\ALL_Results_20211010\6_S3_CROP_farm_crop_prod&use.dta", clear

gen     crop = 1  if crop_name==101 | crop_name==105 // wheat
replace crop = 2  if crop_name==103 | crop_name==106 // barley
replace crop = 3  if crop_name==109 | crop_name==143 // maize
drop if crop==.
gen s3q1_1_ij = s3q1_1_i + s3q1_1_j
gen s3q1_1_ef = s3q1_1_e + s3q1_1_f	
gen  value = value_tot/1000
collapse (sum) stock_beginning s3q1_1_b s3q1_1_c  value s3q1_1_g s3q1_1_h s3q1_1_ij s3q1_1_ef s3q1_1_k s3q1_1_a (first) III_a w_all_hij_ann legal_status, by(agris_id crop)


			levelsof crop
			local categ  = r(levels)

			levelsof III_a
			local marz=r(levels)

			levelsof legal_status
			local ls = r(levels)

			foreach l in `ls'{
				foreach i in `marz' {

				levelsof crop if III_a== `i' & legal_status==`l'
				local present_`i' = r(levels) 
				local missing_`i' : list categ - present_`i' 

					foreach id in `missing_`i''{
						if `id'>0{
								set obs `=_N+1'
							replace crop =`id' if _n==_N
							replace III_a=`i' if _n==_N
							replace w_all_hij_ann = 1  if _n==_N
							replace legal_status = `l' if _n==_N
						}
					}
				}
			}	

			

local varb = "stock_beginning s3q1_1_b s3q1_1_c  value s3q1_1_g s3q1_1_h s3q1_1_ij s3q1_1_ef s3q1_1_k s3q1_1_a"

foreach i of local varb {
gen `i'_Q = `i' * w_all_hij_ann
replace `i'_Q=0 if `i'_Q==.
gen nh_`i'_Q = w_all_hij_ann if `i'_Q!=0
replace nh_`i'_Q=0 if nh_`i'_Q==.
}


// nh_stock_beginning_Q stock_beginning_Q nh_s3q1_1_b_Q s3q1_1_b_Q nh_s3q1_1_c_Q s3q1_1_c_Q value_Q nh_s3q1_1_g_Q s3q1_1_g_Q nh_s3q1_1_h_Q s3q1_1_h_Q nh_s3q1_1_ij_Q s3q1_1_ij_Q nh_s3q1_1_ef_Q s3q1_1_ef_Q nh_s3q1_1_k_Q s3q1_1_k_Q





tabstat  nh_stock_beginning_Q stock_beginning_Q nh_s3q1_1_b_Q s3q1_1_b_Q nh_s3q1_1_c_Q s3q1_1_c_Q value_Q nh_s3q1_1_g_Q s3q1_1_g_Q nh_s3q1_1_h_Q s3q1_1_h_Q nh_s3q1_1_ij_Q s3q1_1_ij_Q nh_s3q1_1_ef_Q s3q1_1_ef_Q nh_s3q1_1_k_Q s3q1_1_k_Q nh_s3q1_1_a_Q s3q1_1_a_Q  if III_a == 4 & legal_status==1 , s(sum) by( crop) save
matrix A1 = (r(Stat1) \ r(Stat2) \ r(Stat3) )
 
tabstat  nh_stock_beginning_Q stock_beginning_Q nh_s3q1_1_b_Q s3q1_1_b_Q nh_s3q1_1_c_Q s3q1_1_c_Q value_Q nh_s3q1_1_g_Q s3q1_1_g_Q nh_s3q1_1_h_Q s3q1_1_h_Q nh_s3q1_1_ij_Q s3q1_1_ij_Q nh_s3q1_1_ef_Q s3q1_1_ef_Q nh_s3q1_1_k_Q s3q1_1_k_Q nh_s3q1_1_a_Q s3q1_1_a_Q  if III_a == 4 & legal_status==2 ,  s(sum) by( crop) save
matrix A2 = (r(Stat1) \ r(Stat2) \ r(Stat3) )


tabstat  nh_stock_beginning_Q stock_beginning_Q nh_s3q1_1_b_Q s3q1_1_b_Q nh_s3q1_1_c_Q s3q1_1_c_Q value_Q nh_s3q1_1_g_Q s3q1_1_g_Q nh_s3q1_1_h_Q s3q1_1_h_Q nh_s3q1_1_ij_Q s3q1_1_ij_Q nh_s3q1_1_ef_Q s3q1_1_ef_Q nh_s3q1_1_k_Q s3q1_1_k_Q nh_s3q1_1_a_Q s3q1_1_a_Q  if III_a == 7 & legal_status==1 , s(sum) by( crop) save 
matrix K1 = (r(Stat1) \ r(Stat2) \ r(Stat3) )

tabstat  nh_stock_beginning_Q stock_beginning_Q nh_s3q1_1_b_Q s3q1_1_b_Q nh_s3q1_1_c_Q s3q1_1_c_Q value_Q nh_s3q1_1_g_Q s3q1_1_g_Q nh_s3q1_1_h_Q s3q1_1_h_Q nh_s3q1_1_ij_Q s3q1_1_ij_Q nh_s3q1_1_ef_Q s3q1_1_ef_Q nh_s3q1_1_k_Q s3q1_1_k_Q nh_s3q1_1_a_Q s3q1_1_a_Q  if III_a == 7 & legal_status==2 ,  s(sum) by( crop) save
matrix K2 = (r(Stat1) \ r(Stat2) \ r(Stat3) )
 
 
 
 tabstat  nh_stock_beginning_Q stock_beginning_Q nh_s3q1_1_b_Q s3q1_1_b_Q nh_s3q1_1_c_Q s3q1_1_c_Q value_Q nh_s3q1_1_g_Q s3q1_1_g_Q nh_s3q1_1_h_Q s3q1_1_h_Q nh_s3q1_1_ij_Q s3q1_1_ij_Q nh_s3q1_1_ef_Q s3q1_1_ef_Q nh_s3q1_1_k_Q s3q1_1_k_Q nh_s3q1_1_a_Q s3q1_1_a_Q  if III_a == 8 & legal_status==1 , s(sum) by( crop) save 
matrix Sh1 = (r(Stat1) \ r(Stat2) \ r(Stat3) )

tabstat  nh_stock_beginning_Q stock_beginning_Q nh_s3q1_1_b_Q s3q1_1_b_Q nh_s3q1_1_c_Q s3q1_1_c_Q value_Q nh_s3q1_1_g_Q s3q1_1_g_Q nh_s3q1_1_h_Q s3q1_1_h_Q nh_s3q1_1_ij_Q s3q1_1_ij_Q nh_s3q1_1_ef_Q s3q1_1_ef_Q nh_s3q1_1_k_Q s3q1_1_k_Q nh_s3q1_1_a_Q s3q1_1_a_Q  if III_a == 8 & legal_status==2 ,  s(sum) by( crop ) save
matrix Sh2 = (r(Stat1) \ r(Stat2) \ r(Stat3) )


tabstat  nh_stock_beginning_Q stock_beginning_Q nh_s3q1_1_b_Q s3q1_1_b_Q nh_s3q1_1_c_Q s3q1_1_c_Q value_Q nh_s3q1_1_g_Q s3q1_1_g_Q nh_s3q1_1_h_Q s3q1_1_h_Q nh_s3q1_1_ij_Q s3q1_1_ij_Q nh_s3q1_1_ef_Q s3q1_1_ef_Q nh_s3q1_1_k_Q s3q1_1_k_Q nh_s3q1_1_a_Q s3q1_1_a_Q  if III_a == 11 & legal_status==1 , s(sum) by( crop) save 
matrix T1 = (r(Stat1) \ r(Stat2) \ r(Stat3) ) 


tabstat  nh_stock_beginning_Q stock_beginning_Q nh_s3q1_1_b_Q s3q1_1_b_Q nh_s3q1_1_c_Q s3q1_1_c_Q value_Q nh_s3q1_1_g_Q s3q1_1_g_Q nh_s3q1_1_h_Q s3q1_1_h_Q nh_s3q1_1_ij_Q s3q1_1_ij_Q nh_s3q1_1_ef_Q s3q1_1_ef_Q nh_s3q1_1_k_Q s3q1_1_k_Q nh_s3q1_1_a_Q s3q1_1_a_Q  if III_a == 11 & legal_status==2 ,  s(sum) by( crop)save
matrix T2 = (r(Stat1) \ r(Stat2) \ r(Stat3) )

putexcel set C:\Users\avet\Documents\Final_tables, sheet(Crop_use) modify

putexcel (G12) = matrix(A1)
putexcel (G22) = matrix(A2)

putexcel (G31) = matrix(K1)
putexcel (G41) = matrix(K2)

putexcel (G50) = matrix(Sh1)
putexcel (G60) = matrix(Sh2)

putexcel (G69) = matrix(T1)
putexcel (G79) = matrix(T2)













use "C:\Users\avet\Desktop\Mariana\ALL_Results_20211010\7_S3_VEG_farm_veg_prod&use_.dta", clear

gen     crop = 1  if veg_label=="Cucumber"
replace crop = 2  if veg_label=="Tomato"
replace crop = 3  if veg_label=="Potato" 
drop if crop==.
rename stock_begining stock_beginning

gen s3q1_2_ij = s3q1_2_i + s3q1_2_j
gen s3q1_2_ef = s3q1_2_e + s3q1_2_f	
gen  value = value_tot/1000
collapse (sum) stock_beginning s3q1_2_b s3q1_2_c  value s3q1_2_g s3q1_2_h s3q1_2_ij s3q1_2_ef s3q1_2_k s3q1_2_a (first) III_a w_all_hij_ann legal_status, by(agris_id crop)
			
			levelsof crop
			local categ  = r(levels)

			levelsof III_a
			local marz=r(levels)

			levelsof legal_status
			local ls = r(levels)

			foreach l in `ls'{
				foreach i in `marz' {

				levelsof crop if III_a== `i' & legal_status==`l'
				local present_`i' = r(levels) 
				local missing_`i' : list categ - present_`i' 

					foreach id in `missing_`i''{
						if `id'>0{
								set obs `=_N+1'
							replace crop =`id' if _n==_N
							replace III_a=`i' if _n==_N
							replace w_all_hij_ann = 1  if _n==_N
							replace legal_status = `l' if _n==_N
						}
					}
				}
			}	

local varb = "stock_beginning s3q1_2_b s3q1_2_c  value s3q1_2_g s3q1_2_h s3q1_2_ij s3q1_2_ef s3q1_2_k s3q1_2_a"

foreach i of local varb {
gen `i'_Q = `i' * w_all_hij_ann
replace `i'_Q=0 if `i'_Q==.
gen nh_`i'_Q = w_all_hij_ann if `i'_Q!=0
replace nh_`i'_Q=0 if nh_`i'_Q==.
}


// nh_stock_beginning_Q stock_beginning_Q nh_s3q1_2_b_Q s3q1_2_b_Q nh_s3q1_2_c_Q s3q1_2_c_Q value_Q nh_s3q1_2_g_Q s3q1_2_g_Q nh_s3q1_2_h_Q s3q1_2_h_Q nh_s3q1_2_ij_Q s3q1_2_ij_Q nh_s3q1_2_ef_Q s3q1_2_ef_Q nh_s3q1_2_k_Q s3q1_2_k_Q





tabstat  nh_stock_beginning_Q stock_beginning_Q nh_s3q1_2_b_Q s3q1_2_b_Q nh_s3q1_2_c_Q s3q1_2_c_Q value_Q nh_s3q1_2_g_Q s3q1_2_g_Q nh_s3q1_2_h_Q s3q1_2_h_Q nh_s3q1_2_ij_Q s3q1_2_ij_Q nh_s3q1_2_ef_Q s3q1_2_ef_Q nh_s3q1_2_k_Q s3q1_2_k_Q  nh_s3q1_2_a_Q s3q1_2_a_Q  if III_a == 4 & legal_status==1 , s(sum) by( crop) save
matrix A1 = (r(Stat1) \ r(Stat2) \ r(Stat3) )
 
tabstat  nh_stock_beginning_Q stock_beginning_Q nh_s3q1_2_b_Q s3q1_2_b_Q nh_s3q1_2_c_Q s3q1_2_c_Q value_Q nh_s3q1_2_g_Q s3q1_2_g_Q nh_s3q1_2_h_Q s3q1_2_h_Q nh_s3q1_2_ij_Q s3q1_2_ij_Q nh_s3q1_2_ef_Q s3q1_2_ef_Q nh_s3q1_2_k_Q s3q1_2_k_Q  nh_s3q1_2_a_Q s3q1_2_a_Q  if III_a == 4 & legal_status==2 ,  s(sum) by( crop) save
matrix A2 = (r(Stat1) \ r(Stat2) \ r(Stat3) )


tabstat  nh_stock_beginning_Q stock_beginning_Q nh_s3q1_2_b_Q s3q1_2_b_Q nh_s3q1_2_c_Q s3q1_2_c_Q value_Q nh_s3q1_2_g_Q s3q1_2_g_Q nh_s3q1_2_h_Q s3q1_2_h_Q nh_s3q1_2_ij_Q s3q1_2_ij_Q nh_s3q1_2_ef_Q s3q1_2_ef_Q nh_s3q1_2_k_Q s3q1_2_k_Q  nh_s3q1_2_a_Q s3q1_2_a_Q  if III_a == 7 & legal_status==1 , s(sum) by( crop) save 
matrix K1 = (r(Stat1) \ r(Stat2) \ r(Stat3) )

tabstat  nh_stock_beginning_Q stock_beginning_Q nh_s3q1_2_b_Q s3q1_2_b_Q nh_s3q1_2_c_Q s3q1_2_c_Q value_Q nh_s3q1_2_g_Q s3q1_2_g_Q nh_s3q1_2_h_Q s3q1_2_h_Q nh_s3q1_2_ij_Q s3q1_2_ij_Q nh_s3q1_2_ef_Q s3q1_2_ef_Q nh_s3q1_2_k_Q s3q1_2_k_Q  nh_s3q1_2_a_Q s3q1_2_a_Q  if III_a == 7 & legal_status==2 ,  s(sum) by( crop) save
matrix K2 = (r(Stat1) \ r(Stat2) \ r(Stat3) )
 
 
 
 tabstat  nh_stock_beginning_Q stock_beginning_Q nh_s3q1_2_b_Q s3q1_2_b_Q nh_s3q1_2_c_Q s3q1_2_c_Q value_Q nh_s3q1_2_g_Q s3q1_2_g_Q nh_s3q1_2_h_Q s3q1_2_h_Q nh_s3q1_2_ij_Q s3q1_2_ij_Q nh_s3q1_2_ef_Q s3q1_2_ef_Q nh_s3q1_2_k_Q s3q1_2_k_Q  nh_s3q1_2_a_Q s3q1_2_a_Q  if III_a == 8 & legal_status==1 , s(sum) by( crop) save 
matrix Sh1 = (r(Stat1) \ r(Stat2) \ r(Stat3) )

tabstat  nh_stock_beginning_Q stock_beginning_Q nh_s3q1_2_b_Q s3q1_2_b_Q nh_s3q1_2_c_Q s3q1_2_c_Q value_Q nh_s3q1_2_g_Q s3q1_2_g_Q nh_s3q1_2_h_Q s3q1_2_h_Q nh_s3q1_2_ij_Q s3q1_2_ij_Q nh_s3q1_2_ef_Q s3q1_2_ef_Q nh_s3q1_2_k_Q s3q1_2_k_Q  nh_s3q1_2_a_Q s3q1_2_a_Q  if III_a == 8 & legal_status==2 ,  s(sum) by( crop ) save
matrix Sh2 = (r(Stat1) \ r(Stat2) \ r(Stat3) )


tabstat  nh_stock_beginning_Q stock_beginning_Q nh_s3q1_2_b_Q s3q1_2_b_Q nh_s3q1_2_c_Q s3q1_2_c_Q value_Q nh_s3q1_2_g_Q s3q1_2_g_Q nh_s3q1_2_h_Q s3q1_2_h_Q nh_s3q1_2_ij_Q s3q1_2_ij_Q nh_s3q1_2_ef_Q s3q1_2_ef_Q nh_s3q1_2_k_Q s3q1_2_k_Q  nh_s3q1_2_a_Q s3q1_2_a_Q  if III_a == 11 & legal_status==1 , s(sum) by( crop) save 
matrix T1 = (r(Stat1) \ r(Stat2) \ r(Stat3) )


tabstat  nh_stock_beginning_Q stock_beginning_Q nh_s3q1_2_b_Q s3q1_2_b_Q nh_s3q1_2_c_Q s3q1_2_c_Q value_Q nh_s3q1_2_g_Q s3q1_2_g_Q nh_s3q1_2_h_Q s3q1_2_h_Q nh_s3q1_2_ij_Q s3q1_2_ij_Q nh_s3q1_2_ef_Q s3q1_2_ef_Q nh_s3q1_2_k_Q s3q1_2_k_Q  nh_s3q1_2_a_Q s3q1_2_a_Q  if III_a == 11 & legal_status==2 ,  s(sum) by( crop)save
matrix T2 = (r(Stat1) \ r(Stat2) \ r(Stat3) )

putexcel set C:\Users\avet\Documents\Final_tables, sheet(Crop_use) modify

putexcel (G15) = matrix(A1)
putexcel (G25) = matrix(A2)

putexcel (G34) = matrix(K1)
putexcel (G44) = matrix(K2)

putexcel (G53) = matrix(Sh1)
putexcel (G63) = matrix(Sh2)

putexcel (G72) = matrix(T1)
putexcel (G82) = matrix(T2)











use "C:\Users\avet\Desktop\Mariana\ALL_Results_20211010\5a_S3_FRUIT_farm_fruit_prod&use.dta", clear
   
gen     crop = 1  if crop_label=="Apple"
replace crop = 2  if crop_label=="Apricot"
replace crop = 3  if crop_label=="Grape" 
drop if crop==.

gen s3q1_3_ij = s3q1_3_i + s3q1_3_j
gen s3q1_3_ef = s3q1_3_e + s3q1_3_f	
gen  value = value_tot/1000
collapse (sum) stock_beginning s3q1_3_b s3q1_3_c  value s3q1_3_g s3q1_3_h s3q1_3_ij s3q1_3_ef s3q1_3_k s3q1_3_a (first) III_a w_all_hij_ann legal_status, by(agris_id crop)

			levelsof crop
			local categ  = r(levels)

			levelsof III_a
			local marz=r(levels)

			levelsof legal_status
			local ls = r(levels)

			foreach l in `ls'{
				foreach i in `marz' {

				levelsof crop if III_a== `i' & legal_status==`l'
				local present_`i' = r(levels) 
				local missing_`i' : list categ - present_`i' 

					foreach id in `missing_`i''{
						if `id'>0{
								set obs `=_N+1'
							replace crop =`id' if _n==_N
							replace III_a=`i' if _n==_N
							replace w_all_hij_ann = 1  if _n==_N
							replace legal_status = `l' if _n==_N
						}
					}
				}
			}	

local varb = "stock_beginning s3q1_3_b s3q1_3_c  value s3q1_3_g s3q1_3_h s3q1_3_ij s3q1_3_ef s3q1_3_k s3q1_3_a"

foreach i of local varb {
gen `i'_Q = `i' * w_all_hij_ann
replace `i'_Q=0 if `i'_Q==.
gen nh_`i'_Q = w_all_hij_ann if `i'_Q!=0
replace nh_`i'_Q=0 if nh_`i'_Q==.
}


// nh_stock_beginning_Q stock_beginning_Q nh_s3q1_3_b_Q s3q1_3_b_Q nh_s3q1_3_c_Q s3q1_3_c_Q value_Q nh_s3q1_3_g_Q s3q1_3_g_Q nh_s3q1_3_h_Q s3q1_3_h_Q nh_s3q1_3_ij_Q s3q1_3_ij_Q nh_s3q1_3_ef_Q s3q1_3_ef_Q nh_s3q1_3_k_Q s3q1_3_k_Q





tabstat  nh_stock_beginning_Q stock_beginning_Q nh_s3q1_3_b_Q s3q1_3_b_Q nh_s3q1_3_c_Q s3q1_3_c_Q value_Q nh_s3q1_3_g_Q s3q1_3_g_Q nh_s3q1_3_h_Q s3q1_3_h_Q nh_s3q1_3_ij_Q s3q1_3_ij_Q nh_s3q1_3_ef_Q s3q1_3_ef_Q nh_s3q1_3_k_Q s3q1_3_k_Q  nh_s3q1_3_a_Q s3q1_3_a_Q  if III_a == 4 & legal_status==1 , s(sum) by( crop) save
matrix A1 = (r(Stat1) \ r(Stat2) \ r(Stat3) )
 
tabstat  nh_stock_beginning_Q stock_beginning_Q nh_s3q1_3_b_Q s3q1_3_b_Q nh_s3q1_3_c_Q s3q1_3_c_Q value_Q nh_s3q1_3_g_Q s3q1_3_g_Q nh_s3q1_3_h_Q s3q1_3_h_Q nh_s3q1_3_ij_Q s3q1_3_ij_Q nh_s3q1_3_ef_Q s3q1_3_ef_Q nh_s3q1_3_k_Q s3q1_3_k_Q  nh_s3q1_3_a_Q s3q1_3_a_Q  if III_a == 4 & legal_status==2 ,  s(sum) by( crop) save
matrix A2 = (r(Stat1) \ r(Stat2) \ r(Stat3) )


tabstat  nh_stock_beginning_Q stock_beginning_Q nh_s3q1_3_b_Q s3q1_3_b_Q nh_s3q1_3_c_Q s3q1_3_c_Q value_Q nh_s3q1_3_g_Q s3q1_3_g_Q nh_s3q1_3_h_Q s3q1_3_h_Q nh_s3q1_3_ij_Q s3q1_3_ij_Q nh_s3q1_3_ef_Q s3q1_3_ef_Q nh_s3q1_3_k_Q s3q1_3_k_Q  nh_s3q1_3_a_Q s3q1_3_a_Q  if III_a == 7 & legal_status==1 , s(sum) by( crop) save 
matrix K1 = (r(Stat1) \ r(Stat2) \ r(Stat3) )

tabstat  nh_stock_beginning_Q stock_beginning_Q nh_s3q1_3_b_Q s3q1_3_b_Q nh_s3q1_3_c_Q s3q1_3_c_Q value_Q nh_s3q1_3_g_Q s3q1_3_g_Q nh_s3q1_3_h_Q s3q1_3_h_Q nh_s3q1_3_ij_Q s3q1_3_ij_Q nh_s3q1_3_ef_Q s3q1_3_ef_Q nh_s3q1_3_k_Q s3q1_3_k_Q  nh_s3q1_3_a_Q s3q1_3_a_Q  if III_a == 7 & legal_status==2 ,  s(sum) by( crop) save
matrix K2 = (r(Stat1) \ r(Stat2) \ r(Stat3) )
 
 
 
 tabstat  nh_stock_beginning_Q stock_beginning_Q nh_s3q1_3_b_Q s3q1_3_b_Q nh_s3q1_3_c_Q s3q1_3_c_Q value_Q nh_s3q1_3_g_Q s3q1_3_g_Q nh_s3q1_3_h_Q s3q1_3_h_Q nh_s3q1_3_ij_Q s3q1_3_ij_Q nh_s3q1_3_ef_Q s3q1_3_ef_Q nh_s3q1_3_k_Q s3q1_3_k_Q  nh_s3q1_3_a_Q s3q1_3_a_Q  if III_a == 8 & legal_status==1 , s(sum) by( crop) save 
matrix Sh1 = (r(Stat1) \ r(Stat2) \ r(Stat3) )

tabstat  nh_stock_beginning_Q stock_beginning_Q nh_s3q1_3_b_Q s3q1_3_b_Q nh_s3q1_3_c_Q s3q1_3_c_Q value_Q nh_s3q1_3_g_Q s3q1_3_g_Q nh_s3q1_3_h_Q s3q1_3_h_Q nh_s3q1_3_ij_Q s3q1_3_ij_Q nh_s3q1_3_ef_Q s3q1_3_ef_Q nh_s3q1_3_k_Q s3q1_3_k_Q  nh_s3q1_3_a_Q s3q1_3_a_Q  if III_a == 8 & legal_status==2 ,  s(sum) by( crop ) save
matrix Sh2 = (r(Stat1) \ r(Stat2) \ r(Stat3) )


tabstat  nh_stock_beginning_Q stock_beginning_Q nh_s3q1_3_b_Q s3q1_3_b_Q nh_s3q1_3_c_Q s3q1_3_c_Q value_Q nh_s3q1_3_g_Q s3q1_3_g_Q nh_s3q1_3_h_Q s3q1_3_h_Q nh_s3q1_3_ij_Q s3q1_3_ij_Q nh_s3q1_3_ef_Q s3q1_3_ef_Q nh_s3q1_3_k_Q s3q1_3_k_Q  nh_s3q1_3_a_Q s3q1_3_a_Q  if III_a == 11 & legal_status==1 , s(sum) by( crop) save 
matrix T1 = (r(Stat1) \ r(Stat2) \ r(Stat3) )


tabstat  nh_stock_beginning_Q stock_beginning_Q nh_s3q1_3_b_Q s3q1_3_b_Q nh_s3q1_3_c_Q s3q1_3_c_Q value_Q nh_s3q1_3_g_Q s3q1_3_g_Q nh_s3q1_3_h_Q s3q1_3_h_Q nh_s3q1_3_ij_Q s3q1_3_ij_Q nh_s3q1_3_ef_Q s3q1_3_ef_Q nh_s3q1_3_k_Q s3q1_3_k_Q  nh_s3q1_3_a_Q s3q1_3_a_Q  if III_a == 11 & legal_status==2 ,  s(sum) by( crop)save
matrix T2 = (r(Stat1) \ r(Stat2) \ r(Stat3) )

putexcel set C:\Users\avet\Documents\Final_tables, sheet(Crop_use) modify

putexcel (G18) = matrix(A1)
putexcel (G28) = matrix(A2)

putexcel (G37) = matrix(K1)
putexcel (G47) = matrix(K2)

putexcel (G56) = matrix(Sh1)
putexcel (G66) = matrix(Sh2)

putexcel (G75) = matrix(T1)
putexcel (G85) = matrix(T2)

