#V3.30a
#C 2015 Hake control file - pre-SRG
#_data_and_control_files: 2015hake_data.SS // 2015hake_control.SS
#_SS-V3.30a-safe;_05/25/2015;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_11.2
1  #_N_Growth_Patterns
1 #_N_platoons_Within_GrowthPattern 
#_Cond 1 #_Morph_between/within_stdev_ratio (no read if N_morphs=1)
#_Cond  1 #vector_Morphdist_(-1_in_first_val_gives_normal_approx)
#
1 # recr_dist_method for parameters:  1=like 3.24; 2=main effects for GP, Settle timing, Area; 3=each Settle entity; 4=none when N_GP*Nsettle*pop==1
1 # Recruitment: 1=global; 2=by area
1 #  number of recruitment settlement assignments 
0 # year_x_area_x_settlement_event interaction requested (only for recr_dist_method=1)
#GPat month  area (for each settlement assignment)
 1 1 1
#
#_Cond 0 # N_movement_definitions goes here if N_areas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
0 #_Nblock_Patterns
#_Cond 0 #_blocks_per_pattern 
# begin and end years of blocks
#
0.5 #_fracfemale 
0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate
  #_no additional input for selected M option; read 1P per morph
1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_speciific_K; 4=not implemented
1 #_Growth_Age_for_L1
20 #_Growth_Age_for_L2 (999 to use as Linf)
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
5 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=read fec and wt from wtatage.ss
#_placeholder for empirical age-maturity by growth pattern
2 #_First_Mature_Age
1 #_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=age-specific fxn
1 #_parameter_offset_approach (1=none, 2= M, G, CV_G as offset from female-GP1, 3=like SS2 V1.x)
1 #_env/block/dev_adjust_method (1=standard; 2=logistic transform keeps in base parm bounds; 3=standard w/ no bound check)
#
#_growth_parms
#_LO HI INIT PRIOR PR_type SD PHASE env-var use_dev dev_minyr dev_maxyr dev_stddev Block Block_Fxn
 0.05 0.4 0.215077 -1.60944 3 0.1 4 0 2 2003 2009 0.05 0 0 # NatM_p_1_Fem_GP_1
 2 15 5 32 -1 99 -5 0 0 0 0 0 0 0 # L_at_Amin_Fem_GP_1
 45 60 53.2 50 -1 99 -3 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1
 0.2 0.4 0.3 0.3 -1 99 -3 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
 0.03 0.16 0.066 0.1 -1 99 -5 0 0 0 0 0 0 0 # CV_young_Fem_GP_1
 0.03 0.16 0.062 0.1 -1 99 -5 0 0 0 0 0 0 0 # CV_old_Fem_GP_1
 -3 3 7e-006 7e-006 -1 99 -50 0 0 0 0 0 0 0 # Wtlen_1_Fem
 -3 3 2.9624 2.9624 -1 99 -50 0 0 0 0 0 0 0 # Wtlen_2_Fem
 -3 43 36.89 36.89 -1 99 -50 0 0 0 0 0 0 0 # Mat50%_Fem
 -3 3 -0.48 -0.48 -1 99 -50 0 0 0 0 0 0 0 # Mat_slope_Fem
 -3 3 1 1 -1 99 -50 0 0 0 0 0 0 0 # Eggs/kg_inter_Fem
 -3 3 0 0 -1 99 -50 0 0 0 0 0 0 0 # Eggs/kg_slope_wt_Fem
 0 2 1 1 -1 99 -50 0 0 0 0 0 0 0 # RecrDist_GP_1
 0 2 1 1 -1 99 -50 0 0 0 0 0 0 0 # RecrDist_Area_1
 0 2 1 1 -1 99 -50 0 0 0 0 0 0 0 # RecrDist_Bseas_1
 0 2 1 1 -1 99 -50 0 0 0 0 0 0 0 # CohortGrowDev
#
#_Cond 0  #custom_MG-env_setup (0/1)
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no MG-environ parameters
#
#_Cond 0  #custom_MG-block_setup (0/1)
#_LO HI INIT PRIOR PR_type SD PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no MG-block parameters
#_Cond No MG parm trends 
#
#_seasonal_effects_on_biology_parms
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_LO HI INIT PRIOR PR_type SD PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
# standard error parameters for MG devs
 0.0125 0.2 0.05 0.05 0 0.25 -5 # NatM_p_1_Fem_GP_1_dev_se
 0 0.99 0 0.2 0 0.2 -5 # NatM_p_1_Fem_GP_1_dev_rho # 
 # 1 2003 0 # NatM_p_1_Fem_GP_1_DEVadd_2003
 # 1 2004 0 # NatM_p_1_Fem_GP_1_DEVadd_2004
 # 1 2005 0 # NatM_p_1_Fem_GP_1_DEVadd_2005
 # 1 2006 0 # NatM_p_1_Fem_GP_1_DEVadd_2006
 # 1 2007 0 # NatM_p_1_Fem_GP_1_DEVadd_2007
 # 1 2008 0 # NatM_p_1_Fem_GP_1_DEVadd_2008
 # 1 2009 0 # NatM_p_1_Fem_GP_1_DEVadd_2009
#
-5 #_MGparm_Dev_Phase
#
#_Spawner-Recruitment
3 #_SR_function: 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=survival_3Parm; 8=Shepard_3Parm
#_LO HI INIT PRIOR PR_type SD PHASE
 13 17 14.7559 15 -1 99 1 # SR_LN(R0)
 0.2 1 0.86267 0.777 2 0.113 4 # SR_BH_steep
 1 1.6 1.4 1.1 -1 99 -6 # SR_sigmaR
 -5 5 0 0 -1 99 -50 # SR_envlink
 -5 5 0 0 -1 99 -50 # SR_R1_offset
 0 2 0 1 -1 99 -50 # SR_autocorr
0 #_SR_env_link
0 #_SR_env_target_0=none;1=devs;_2=R0;_3=steepness
1 #do_recdev:  0=none; 1=devvector; 2=simple deviations
1970 # first year of main recr_devs; early devs can preceed this era
2010 # last year of main recr_devs; forecast devs start in following year
1 #_recdev phase 
1 # (0/1) to read 13 advanced options
 1946 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 3 #_recdev_early_phase
 5 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1965 #_last_early_yr_nobias_adj_in_MPD
 1971 #_first_yr_fullbias_adj_in_MPD
 2011 #_last_yr_fullbias_adj_in_MPD
 2013 #_first_recent_yr_nobias_adj_in_MPD
 0.87 #_max_bias_adj_in_MPD (-1 to override ramp and set biasadj=1.0 for all estimated recdevs)
 0 #_period of cycles in recruitment (N parms read below)
 -6 #min rec_dev
 6 #max rec_dev
 0 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# read specified recr devs
#_Yr Input_value
#
# all recruitment deviations
#  1946E 1947E 1948E 1949E 1950E 1951E 1952E 1953E 1954E 1955E 1956E 1957E 1958E 1959E 1960E 1961E 1962E 1963E 1964E 1965E 1966E 1967E 1968E 1969E 1970R 1971R 1972R 1973R 1974R 1975R 1976R 1977R 1978R 1979R 1980R 1981R 1982R 1983R 1984R 1985R 1986R 1987R 1988R 1989R 1990R 1991R 1992R 1993R 1994R 1995R 1996R 1997R 1998R 1999R 2000R 2001R 2002R 2003R 2004R 2005R 2006R 2007R 2008R 2009R 2010R 2011F 2012F 2013F 2014F 2015F 2016F 2017F
#  -0.376155 -0.116965 -0.141517 -0.170471 -0.20434 -0.243627 -0.288531 -0.340747 -0.398357 -0.459251 -0.52594 -0.59455 -0.664121 -0.733427 -0.795878 -0.84012 -0.850721 -0.819652 -0.728066 -0.520467 -0.245605 0.484846 0.334195 -0.226831 1.72008 -0.197705 -0.726253 1.30994 -0.887193 0.0969198 -1.05558 1.46347 -1.28746 -0.125508 2.64745 -1.17425 -1.42716 -0.918323 2.3847 -1.63987 -1.59278 1.51862 0.562883 -1.74619 1.33758 -0.57134 -1.65656 1.07718 0.883677 0.194622 0.415833 -0.0185293 0.519089 2.32972 -1.00602 -0.238632 -2.64414 0.217059 -2.61406 0.745739 0.493419 -3.04047 1.74436 0.243358 2.66234 -0.725026 0.311272 -0.227299 0 0 0 0
# implementation error by year in forecast:  0 0 0
#
#Fishing Mortality info 
0.1 # F ballpark
-1999 # F ballpark year (neg value to disable)
1 # F_Method:  1=Pope; 2=instan. F; 3=hybrid (hybrid is recommended)
0.95 # max F or harvest rate, depends on F_Method
# no additional F input needed for Fmethod 1
# if Fmethod=2; read overall start F value; overall phase; N detailed inputs to read
# if Fmethod=3; read N iterations for tuning for Fmethod 3
#
#_initial_F_parms; count = 0
#_LO HI INIT PRIOR PR_type SD PHASE
#
# F rates by fleet
# Yr:  1966 1967 1968 1969 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017
# seas:  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# Fishery 0.070343 0.12006 0.0762717 0.115096 0.146996 0.0978743 0.0726213 0.0805836 0.101365 0.0856613 0.074524 0.0497441 0.0452964 0.0560904 0.0414763 0.0693972 0.0582625 0.0420342 0.0467108 0.0380131 0.0652782 0.0696808 0.075032 0.108822 0.0840561 0.111767 0.1305 0.105649 0.201733 0.162123 0.207376 0.230933 0.265044 0.283831 0.205559 0.177955 0.08952 0.0999587 0.185695 0.21518 0.28325 0.314854 0.400331 0.267318 0.340821 0.295885 0.187958 0.150949 0.131276 0.310191
#
#_Q_setup
 # Q_type options:  <0=mirror, 0=float_nobiasadj, 1=float_biasadj, 2=parm_nobiasadj, 3=parm_w_random_dev, 4=parm_w_randwalk, 5=mean_unbiased_float_assign_to_parm
#_for_env-var:_enter_index_of_the_env-var_to_be_linked
#_Den-dep  env-var  extra_se  Q_type Q_offset
 0 0 0 0 0 # 1 Fishery
 0 0 1 0 0 # 2 Acoustic_Survey
#
#_Cond 0 #_If q has random component, then 0=read one parm for each fleet with random q; 1=read a parm for each year of index
#_Q_parms(if_any);Qunits_are_ln(q)
# LO HI INIT PRIOR PR_type SD PHASE
 0.05 1.2 0.306941 0.0755 -1 0.1 4 # Q_extraSD_Acoustic_Survey(2)
#
#_size_selex_types
#discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead
#_Pattern Discard Male Special
 0 0 0 0 # 1 Fishery
 0 0 0 0 # 2 Acoustic_Survey
#
#_age_selex_types
#_Pattern ___ Male Special
 17 0 0 20 # 1 Fishery
 17 0 0 20 # 2 Acoustic_Survey
#_LO HI INIT PRIOR PR_type SD PHASE env-var use_dev dev_minyr dev_maxyr dev_stddev Block Block_Fxn
 -1002 3 -1000 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P1_Fishery(1)
 -1 1 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P2_Fishery(1)
 -5 9 3.17088 -1 -1 0.01 2 0 2 1991 2014 0.03 0 0 # AgeSel_P3_Fishery(1)
 -5 9 1.62521 -1 -1 0.01 2 0 2 1991 2014 0.03 0 0 # AgeSel_P4_Fishery(1)
 -5 9 0.264906 -1 -1 0.01 2 0 2 1991 2014 0.03 0 0 # AgeSel_P5_Fishery(1)
 -5 9 0.11684 -1 -1 0.01 2 0 2 1991 2014 0.03 0 0 # AgeSel_P6_Fishery(1)
 -5 9 0.320442 -1 -1 0.01 2 0 2 1991 2014 0.03 0 0 # AgeSel_P7_Fishery(1)
 -5 9 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P8_Fishery(1)
 -5 9 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P9_Fishery(1)
 -5 9 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P10_Fishery(1)
 -5 9 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P11_Fishery(1)
 -5 9 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P12_Fishery(1)
 -5 9 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P13_Fishery(1)
 -5 9 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P14_Fishery(1)
 -5 9 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P15_Fishery(1)
 -5 9 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P16_Fishery(1)
 -5 9 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P17_Fishery(1)
 -5 9 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P18_Fishery(1)
 -5 9 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P19_Fishery(1)
 -5 9 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P20_Fishery(1)
 -5 9 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P21_Fishery(1)
 -1002 3 -1000 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P1_Acoustic_Survey(2)
 -1002 3 -1000 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P2_Acoustic_Survey(2)
 -1 1 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P3_Acoustic_Survey(2)
 -5 9 0.375247 -1 -1 0.01 2 0 0 0 0 0 0 0 # AgeSel_P4_Acoustic_Survey(2)
 -5 9 0.0455991 -1 -1 0.01 2 0 0 0 0 0 0 0 # AgeSel_P5_Acoustic_Survey(2)
 -5 9 -0.133168 -1 -1 0.01 2 0 0 0 0 0 0 0 # AgeSel_P6_Acoustic_Survey(2)
 -5 9 0.481296 -1 -1 0.01 2 0 0 0 0 0 0 0 # AgeSel_P7_Acoustic_Survey(2)
 -5 9 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P8_Acoustic_Survey(2)
 -5 9 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P9_Acoustic_Survey(2)
 -5 9 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P10_Acoustic_Survey(2)
 -5 9 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P11_Acoustic_Survey(2)
 -5 9 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P12_Acoustic_Survey(2)
 -5 9 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P13_Acoustic_Survey(2)
 -5 9 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P14_Acoustic_Survey(2)
 -5 9 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P15_Acoustic_Survey(2)
 -5 9 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P16_Acoustic_Survey(2)
 -5 9 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P17_Acoustic_Survey(2)
 -5 9 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P18_Acoustic_Survey(2)
 -5 9 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P19_Acoustic_Survey(2)
 -5 9 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P20_Acoustic_Survey(2)
 -5 9 0 -1 -1 0.01 -2 0 0 0 0 0 0 0 # AgeSel_P21_Acoustic_Survey(2)
#_Cond 0 #_custom_sel-env_setup (0/1) 
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no enviro fxns
#_Cond 0 #_custom_sel-blk_setup (0/1) 
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no block usage
#_Cond No selex parm trends 
# standard error parameters for selparm devs
 0.0075 0.12 0.03 0.03 0 0.25 -5 # AgeSel_P3_Fishery(1)_dev_se
 0 0.99 0 0.2 0 0.2 -5 # AgeSel_P3_Fishery(1)_dev_rho # 
 0.0075 0.12 0.03 0.03 0 0.25 -5 # AgeSel_P4_Fishery(1)_dev_se
 0 0.99 0 0.2 0 0.2 -5 # AgeSel_P4_Fishery(1)_dev_rho # 
 0.0075 0.12 0.03 0.03 0 0.25 -5 # AgeSel_P5_Fishery(1)_dev_se
 0 0.99 0 0.2 0 0.2 -5 # AgeSel_P5_Fishery(1)_dev_rho # 
 0.0075 0.12 0.03 0.03 0 0.25 -5 # AgeSel_P6_Fishery(1)_dev_se
 0 0.99 0 0.2 0 0.2 -5 # AgeSel_P6_Fishery(1)_dev_rho # 
 0.0075 0.12 0.03 0.03 0 0.25 -5 # AgeSel_P7_Fishery(1)_dev_se
 0 0.99 0 0.2 0 0.2 -5 # AgeSel_P7_Fishery(1)_dev_rho # 
# 3.82112e-005 # AgeSel_P3_Fishery(1)_DEVadd_1991
# 8.8721e-007 # AgeSel_P3_Fishery(1)_DEVadd_1992
# 1.5984e-006 # AgeSel_P3_Fishery(1)_DEVadd_1993
# 7.82702e-005 # AgeSel_P3_Fishery(1)_DEVadd_1994
# 4.58396e-005 # AgeSel_P3_Fishery(1)_DEVadd_1995
# 2.95661e-005 # AgeSel_P3_Fishery(1)_DEVadd_1996
# 5.30376e-005 # AgeSel_P3_Fishery(1)_DEVadd_1997
# 4.24643e-005 # AgeSel_P3_Fishery(1)_DEVadd_1998
# 0.000168005 # AgeSel_P3_Fishery(1)_DEVadd_1999
# 0.000654442 # AgeSel_P3_Fishery(1)_DEVadd_2000
# 2.18768e-005 # AgeSel_P3_Fishery(1)_DEVadd_2001
# 2.21096e-005 # AgeSel_P3_Fishery(1)_DEVadd_2002
# 1.62221e-006 # AgeSel_P3_Fishery(1)_DEVadd_2003
# 5.70534e-005 # AgeSel_P3_Fishery(1)_DEVadd_2004
# 3.99872e-006 # AgeSel_P3_Fishery(1)_DEVadd_2005
# 1.95616e-005 # AgeSel_P3_Fishery(1)_DEVadd_2006
# 8.37013e-005 # AgeSel_P3_Fishery(1)_DEVadd_2007
# -4.75129e-006 # AgeSel_P3_Fishery(1)_DEVadd_2008
# 0.00065083 # AgeSel_P3_Fishery(1)_DEVadd_2009
# 0.000362857 # AgeSel_P3_Fishery(1)_DEVadd_2010
# 0.000779084 # AgeSel_P3_Fishery(1)_DEVadd_2011
# 6.09556e-007 # AgeSel_P3_Fishery(1)_DEVadd_2012
# 0.000143605 # AgeSel_P3_Fishery(1)_DEVadd_2013
# 0.000141988 # AgeSel_P3_Fishery(1)_DEVadd_2014
# -7.27638e-005 # AgeSel_P4_Fishery(1)_DEVadd_1991
# 0.000396265 # AgeSel_P4_Fishery(1)_DEVadd_1992
# 0.000133123 # AgeSel_P4_Fishery(1)_DEVadd_1993
# 0.000174157 # AgeSel_P4_Fishery(1)_DEVadd_1994
# 0.00119859 # AgeSel_P4_Fishery(1)_DEVadd_1995
# -0.00184139 # AgeSel_P4_Fishery(1)_DEVadd_1996
# 0.000826079 # AgeSel_P4_Fishery(1)_DEVadd_1997
# 0.000270894 # AgeSel_P4_Fishery(1)_DEVadd_1998
# -0.00228865 # AgeSel_P4_Fishery(1)_DEVadd_1999
# 0.00201674 # AgeSel_P4_Fishery(1)_DEVadd_2000
# 0.00763459 # AgeSel_P4_Fishery(1)_DEVadd_2001
# 0.00032108 # AgeSel_P4_Fishery(1)_DEVadd_2002
# 0.00072979 # AgeSel_P4_Fishery(1)_DEVadd_2003
# 0.000114543 # AgeSel_P4_Fishery(1)_DEVadd_2004
# 0.00175577 # AgeSel_P4_Fishery(1)_DEVadd_2005
# -0.000185306 # AgeSel_P4_Fishery(1)_DEVadd_2006
# -0.00236846 # AgeSel_P4_Fishery(1)_DEVadd_2007
# 0.000225262 # AgeSel_P4_Fishery(1)_DEVadd_2008
# 0.000796556 # AgeSel_P4_Fishery(1)_DEVadd_2009
# 0.00292051 # AgeSel_P4_Fishery(1)_DEVadd_2010
# 0.00205168 # AgeSel_P4_Fishery(1)_DEVadd_2011
# -0.00669055 # AgeSel_P4_Fishery(1)_DEVadd_2012
# 0.000568604 # AgeSel_P4_Fishery(1)_DEVadd_2013
# -0.000198849 # AgeSel_P4_Fishery(1)_DEVadd_2014
# -0.00206125 # AgeSel_P5_Fishery(1)_DEVadd_1991
# 0.000106014 # AgeSel_P5_Fishery(1)_DEVadd_1992
# 8.02922e-005 # AgeSel_P5_Fishery(1)_DEVadd_1993
# 0.000978788 # AgeSel_P5_Fishery(1)_DEVadd_1994
# 0.00135592 # AgeSel_P5_Fishery(1)_DEVadd_1995
# -0.000523281 # AgeSel_P5_Fishery(1)_DEVadd_1996
# -0.000821339 # AgeSel_P5_Fishery(1)_DEVadd_1997
# -0.000997403 # AgeSel_P5_Fishery(1)_DEVadd_1998
# -0.00446244 # AgeSel_P5_Fishery(1)_DEVadd_1999
# 0.00328396 # AgeSel_P5_Fishery(1)_DEVadd_2000
# 0.00708723 # AgeSel_P5_Fishery(1)_DEVadd_2001
# 0.00851753 # AgeSel_P5_Fishery(1)_DEVadd_2002
# 0.00141314 # AgeSel_P5_Fishery(1)_DEVadd_2003
# 0.00053185 # AgeSel_P5_Fishery(1)_DEVadd_2004
# 0.00178849 # AgeSel_P5_Fishery(1)_DEVadd_2005
# 0.000772323 # AgeSel_P5_Fishery(1)_DEVadd_2006
# -0.00255147 # AgeSel_P5_Fishery(1)_DEVadd_2007
# 0.00191062 # AgeSel_P5_Fishery(1)_DEVadd_2008
# 0.00134002 # AgeSel_P5_Fishery(1)_DEVadd_2009
# 0.00290619 # AgeSel_P5_Fishery(1)_DEVadd_2010
# -0.0132128 # AgeSel_P5_Fishery(1)_DEVadd_2011
# -0.00550922 # AgeSel_P5_Fishery(1)_DEVadd_2012
# -0.00193176 # AgeSel_P5_Fishery(1)_DEVadd_2013
# -0.000486476 # AgeSel_P5_Fishery(1)_DEVadd_2014
# -0.0019587 # AgeSel_P6_Fishery(1)_DEVadd_1991
# -0.00044795 # AgeSel_P6_Fishery(1)_DEVadd_1992
# 3.37532e-005 # AgeSel_P6_Fishery(1)_DEVadd_1993
# 0.00318095 # AgeSel_P6_Fishery(1)_DEVadd_1994
# 0.00179009 # AgeSel_P6_Fishery(1)_DEVadd_1995
# -0.000351106 # AgeSel_P6_Fishery(1)_DEVadd_1996
# -0.000919437 # AgeSel_P6_Fishery(1)_DEVadd_1997
# -0.000467261 # AgeSel_P6_Fishery(1)_DEVadd_1998
# -0.00572005 # AgeSel_P6_Fishery(1)_DEVadd_1999
# 0.00542244 # AgeSel_P6_Fishery(1)_DEVadd_2000
# 0.00474711 # AgeSel_P6_Fishery(1)_DEVadd_2001
# 0.00508196 # AgeSel_P6_Fishery(1)_DEVadd_2002
# 0.00214775 # AgeSel_P6_Fishery(1)_DEVadd_2003
# -0.000257934 # AgeSel_P6_Fishery(1)_DEVadd_2004
# 0.00134394 # AgeSel_P6_Fishery(1)_DEVadd_2005
# 0.000734605 # AgeSel_P6_Fishery(1)_DEVadd_2006
# -0.00233993 # AgeSel_P6_Fishery(1)_DEVadd_2007
# 0.00207868 # AgeSel_P6_Fishery(1)_DEVadd_2008
# 0.00287256 # AgeSel_P6_Fishery(1)_DEVadd_2009
# -0.00617561 # AgeSel_P6_Fishery(1)_DEVadd_2010
# -0.0128547 # AgeSel_P6_Fishery(1)_DEVadd_2011
# -0.00531664 # AgeSel_P6_Fishery(1)_DEVadd_2012
# -0.000918017 # AgeSel_P6_Fishery(1)_DEVadd_2013
# 0.00266135 # AgeSel_P6_Fishery(1)_DEVadd_2014
# -0.00199646 # AgeSel_P7_Fishery(1)_DEVadd_1991
# 0.000665422 # AgeSel_P7_Fishery(1)_DEVadd_1992
# -0.000380286 # AgeSel_P7_Fishery(1)_DEVadd_1993
# 0.0032663 # AgeSel_P7_Fishery(1)_DEVadd_1994
# 0.00182937 # AgeSel_P7_Fishery(1)_DEVadd_1995
# 0.000170031 # AgeSel_P7_Fishery(1)_DEVadd_1996
# -0.000784831 # AgeSel_P7_Fishery(1)_DEVadd_1997
# -0.00192718 # AgeSel_P7_Fishery(1)_DEVadd_1998
# -0.00523732 # AgeSel_P7_Fishery(1)_DEVadd_1999
# 0.00562483 # AgeSel_P7_Fishery(1)_DEVadd_2000
# 0.00231717 # AgeSel_P7_Fishery(1)_DEVadd_2001
# 0.00319464 # AgeSel_P7_Fishery(1)_DEVadd_2002
# 0.000589908 # AgeSel_P7_Fishery(1)_DEVadd_2003
# -0.000343359 # AgeSel_P7_Fishery(1)_DEVadd_2004
# 0.000872308 # AgeSel_P7_Fishery(1)_DEVadd_2005
# -0.00159356 # AgeSel_P7_Fishery(1)_DEVadd_2006
# -0.0023177 # AgeSel_P7_Fishery(1)_DEVadd_2007
# -0.000185192 # AgeSel_P7_Fishery(1)_DEVadd_2008
# 0.00304165 # AgeSel_P7_Fishery(1)_DEVadd_2009
# -0.00789079 # AgeSel_P7_Fishery(1)_DEVadd_2010
# -0.00930649 # AgeSel_P7_Fishery(1)_DEVadd_2011
# -0.00532273 # AgeSel_P7_Fishery(1)_DEVadd_2012
# 0.00557399 # AgeSel_P7_Fishery(1)_DEVadd_2013
# 0.00260121 # AgeSel_P7_Fishery(1)_DEVadd_2014
4 #_selparmdev-phase
2 #_env/block/dev_adjust_method (1=standard; 2=logistic trans to keep in base parm bounds; 3=standard w/ no bound check)
#
# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read; 1=read if tags exist
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
1 #_Variance_adjustments_to_input_values
#_fleet: 1 2 
  0 0 #_add_to_survey_CV
  0 0 #_add_to_discard_stddev
  0 0 #_add_to_bodywt_CV
  1 1 #_mult_by_lencomp_N
#  0.12 0.94 #_mult_by_agecomp_N
  1 1 #_mult_by_agecomp_N
  1 1 #_mult_by_size-at-age_N
#
1 #_maxlambdaphase
1 #_sd_offset
#
0 # number of changes to make to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin; 17=F_ballpark
#like_comp fleet/survey  phase  value  sizefreq_method
#
# lambdas (for info only; columns are phases)
#  0 #_CPUE/survey:_1
#  1 #_CPUE/survey:_2
#  1 #_agecomp:_1
#  1 #_agecomp:_2
#  1 #_init_equ_catch
#  1 #_recruitments
#  1 #_parameter-priors
#  1 #_parameter-dev-vectors
#  1 #_crashPenLambda
#  0 # F_ballpark_lambda
1 # (0/1) read specs for more stddev reporting 
 2 2 -1 15 1 1 1 -1 1 # selex type, len/age, year, N selex bins, Growth pattern, N growth ages, NatAge_area(-1 for all), NatAge_yr, N Natages
 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 # vector with selex std bin picks (-1 in first bin to self-generate)
 -1 # vector with growth std bin picks (-1 in first bin to self-generate)
 20 # vector with NatAge std bin picks (-1 in first bin to self-generate)
999

