% pianeta kripton
% pianeta prossimo all'esplosione, causa energia prodotto
% calore nucleo X1
%0,1*x1 se il nucleo non viene utilizzato si raffred
%1.5 reazioni chimiche
% energia prodotta x2
% modellizzare il sistema, capire se deve scappare o no dal pianeta
syms x1 x2 u
% x1
f=[-0.1*x1+1.5+2*x2,3*x1-0.5*u]
% è un sistema lineare
% ha un ingresso
A=[0.1 2;3 0];
B=[1 ,0;0,-0.5];
%NB metti costante come valore dell'ingresso
% quindi u2=1,5, u1 generico
C=[1.5 0];
%u1=-0.5 è un ingresso manipolabile
%u2=1.5 è un ingresso non manipolabile, formalismo
%per valutare la stabilità di questo sistema
% calcolo gli autovalori
aval=eig(A) % per avere stabilità gli autovalori devono avere parte reale <0
% ho un autoavalore positivo, è instabile
