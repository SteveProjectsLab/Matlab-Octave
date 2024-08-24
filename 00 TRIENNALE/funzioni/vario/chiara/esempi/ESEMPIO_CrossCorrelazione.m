clear
close all
clc


dt=0.01;
t=-10:dt:10;
dtau=dt;
tau=-15:dtau:15;  %di quanto traslo la funzione -> è un nuovo set di valori

%Calcolo CrossCorrelazione tra rect e tri

cross_corr=zeros(1, length(tau)); % È su TAU !!

%x=rect(t)
%y=tri(t)

for k=1:length(tau)
   cross_corr(k)= integrale( conj(rect(t)).*tri(t+tau(k)), dt);
end

figure
plot(tau , cross_corr), title( 'CrossCorrelazione rect e tri' )
