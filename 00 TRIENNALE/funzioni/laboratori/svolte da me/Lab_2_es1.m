clear 
close all
clc

dt=0.01;
t=-10:dt:10;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %PARTE 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% realizzare funzione: integrale
% verrà usata nella parte 2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %PARTE 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calcolare area, energia e potenza

s1=rect(t);
s2=tri(t);
s3=sin(2*pi*t/3);

a1=myIntegrale(s1,dt);
a2=myIntegrale(s2,dt);
a3=myIntegrale(s3,dt);

e1=myEnergia(s1,dt);
e2=myEnergia(s2,dt);

T=3;
p1=myPotenzaPeriodico(s3,dt,T,t); 

fprintf('Energia rect = %.2f\n', e1)
fprintf('Area rect = %.2f\n',a1)
fprintf('Energia tri = %.2f\n', e2)
fprintf('Area tri = %.2f\n', a2)
fprintf('Potenza sinusoide = %.2f\n', p1)

