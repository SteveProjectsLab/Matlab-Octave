clear all
close all
clc

% 
num = 1000*[10 1];

den = conv([100 1],[0.1 1]);

G= tf(num,den)

dcgain(G)
[z,p,k]=zpkdata(G,'v')

%bode(G)

Tc=0.001
Gzoh =tf(1,[0,5*Tc 1])

Ga=G*Gzoh

%ora progetto con sisotool

% SPECIFICHE

% 1. devo mettere un integratore
% 2.    PM>75, 
 %  T=1s = 5*cost tempo 
    %polo =-1/cost tempo
    %wt = 5/T=5 deve essere maggiore 


    load C_file C

   Cd = c2d(C,Tc,'Tustin')