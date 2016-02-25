
#devtools::install_github("james-thorson/utilities")
library( ThorsonUtilities )

File = "C:/Users/James.Thorson/Desktop/UW Hideaway/Collaborations/2015 -- Dirichlet-Multinomial/"

# Sample size
N = 0:100

# Parameterization #1 -- ratio
Theta_a = c(0.1,0.5,1,10)
Neff_a = NULL
#for(i in 1:length(Theta_a)) Neff_a = cbind(Neff_a, (1/N + 1/(Theta_a[i]*N+1))^(-1))
for(i in 1:length(Theta_a)) Neff_a = cbind( Neff_a, (1+Theta_a[i]*N)/(1+Theta_a[i]) )

# Parameterization #2 -- fixed ceiling
Theta_b = c(20,50,100,1000)
Neff_b = NULL
#for(i in 1:length(Theta_a)) Neff_b = cbind(Neff_b, (1/N + 1/(Theta_b[i]+1))^(-1))
for(i in 1:length(Theta_a)) Neff_b = cbind( Neff_b, (N+Theta_b[i]*N)/(N+Theta_b[i]) )

# Plot
save_fig( file=paste0(File,"Compare_parameterizations"), width=6, height=3, res=c(200,600), type=c("png","tif"), FUN=function(){
  par( mfrow=c(1,2), mar=c(2,2,1,0), mgp=c(2,0.5,0), tck=-0.02, xaxs="i", yaxs="i", oma=c(1,1,0,1))
  matplot( x=N, y=Neff_a, xlim=range(N), ylim=range(N), type='l', lwd=3, col=c("black","red","blue","green"), lty="solid", main="Parameterization #1" )
  abline(a=0, b=1, lty="dotted")
  legend( "topleft", fill=c("black","red","blue","green"), legend=paste0("Theta=",Theta_a), bty="n")
  matplot( x=N, y=Neff_b, xlim=range(N), ylim=range(N), type='l', lwd=3, col=c("black","red","blue","green"), lty="solid", main="Parameterization #2" )
  abline(a=0, b=1, lty="dotted")
  legend( "topleft", fill=c("black","red","blue","green"), legend=paste0("Beta=",Theta_b), bty="n")
  mtext(side=1, text="Input sample size", outer=TRUE)
  mtext(side=2, text="Effective sample size", outer=TRUE)
})
