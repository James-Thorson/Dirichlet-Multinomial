
########################
# Algorithm for tuning emphasis factors via McAllister-Ianelli method
#
# 1. Run SS3 EM
# 2. Extract equivalent of SsOutput$Length_comp_Eff_N_tuning_check, without using r4ss (sigh...)
# 3. Run code below
# 4. Put object "Matrix" into EM CTL line 357-364 (just below "#_Variance_adjustments_to_input_values"), which I call "emphasis factors" (I think others do too, but always hard to be sure!)
#   ** Note that the line number changes during processing of the EM inputs I think, so these line numbers might need to be checked
# 5. Repeat steps 1-4 twice more (three EM runs total) and treate the third run as final
#
########################

############ Harmonic mean ##############
Matrix = cbind( 'Fishery'=c(0,0,0,1,1,1), 'Accoustic'c(0,0,0,1,1,1)) )
# Length
Match = match( SsOutput$Length_comp_Eff_N_tuning_check[,'Fleet'], 1:2)
Matrix[4,Match] = SsOutput$Length_comp_Eff_N_tuning_check[,'HarEffN/MeanInputN'] * SsOutput$Length_comp_Eff_N_tuning_check[,'Var_Adj']
Matrix[4,] = ifelse( Matrix[4,]>1, 1, Matrix[4,])
# Age
Match = match( SsOutput$Age_comp_Eff_N_tuning_check[,'Fleet'], 1:2)
Matrix[5,Match] = SsOutput$Age_comp_Eff_N_tuning_check[,'HarEffN/MeanInputN'] * SsOutput$Age_comp_Eff_N_tuning_check[,'Var_Adj']
Matrix[5,] = ifelse( Matrix[5,]>1, 1, Matrix[5,])
