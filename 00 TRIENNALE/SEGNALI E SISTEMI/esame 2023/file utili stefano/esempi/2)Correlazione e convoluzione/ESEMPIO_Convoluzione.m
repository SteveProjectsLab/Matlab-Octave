clear
close all
clc


dt=0.01;
t=-10:dt:10;
dtau=dt;
tau=-15:dtau:15; 

%%
%CONVOLUZIONE segnale x=rect(t) e y=tri(t)

%NB: la traslazione è in t e l'integrale è in dtau.

convoulzione = zeros(1, length(t));  % autoConv è definita su t

for k= 1:length(t)
   
    convoulzione(k)=integrale(rect(tau).*tri(t(k)-tau), dtau);
    %Lintegrale è in dtau !
end


figure 
plot( t , convoulzione), title(sprintf('CONVOLUZIONE tra %s e %s', "rect", "tri"))
%stampo su t !



