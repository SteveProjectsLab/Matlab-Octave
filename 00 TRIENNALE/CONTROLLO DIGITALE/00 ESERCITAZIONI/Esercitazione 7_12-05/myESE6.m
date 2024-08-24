close all
clear all
clc
%-------------------------------------------------------------------------
% inserisco il sistema 

num=1;
den = conv([1 1],[1 1]);
G= tf(num,den)

%bode(G)
%grid on

%-------------------------------------------------------------------------
wc=500;
Tc=2*pi/wc
%-------------------------------------------------------------------------
%Sottosistema analogico

Gzoh= tf(1, [0.5*Tc 1])

Ga= G*Gzoh
%-------------------------------------------------------------------------
%progetto il controllore

%sisotool
% esporto C
% devo convertirlo da command window:
%   C=tf(C)
% lo salvo
%   save myC_file
%-------------------------------------------------------------------------
% discretizzo con il metodo di tustin

load myC_file

C_d= c2d(C, Tc, 'tustin')

%-------------------------------------------------------------------------
% apro simulink e simulo il sistema Gcl