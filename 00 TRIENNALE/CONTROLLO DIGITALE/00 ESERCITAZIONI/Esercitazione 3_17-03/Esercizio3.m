clear 
close all
clc

%%SIMULAZIONE SISTEMI TEMPO CONTINUO CON SIMULINK

%Si basa su sintassi degli schemi a blocchi
%Permette di inserire il sistema in modalità grafica

%Scrivo simulink su Command Window
%POi clicco su Blank Model

%Compare un foglio bianco su cui metteremo i blocchi per simulare il sistema

%Simulik vede variabili in COMMAND WINDOW !
%Creo script e lo lancio

% Quando salvo simulink: NO stesso nome del codice!!
% Perchè per Matlab sono la stessa cosa!

% Aggiungo _ sim per distinguerle


%LIBRARY BROWSER:
% per prendere i blocchi

%Clicco su CONTINUOS e ho a disposizione molti blocchi

%Clicco su SOURCES e ho a disposizione gli ingressi

%Unisco con le frecce

%Clicco su SINKS e ho a disposizione vari modi per presentare le uscite

%SCOPE: presenta l'uscita nel tempo

%%
%DEFINIZIONE SISTEMA

num= 10;

den = conv([ 1 1], [1/100 1]);

sys_1= tf(num, den);

[z,p,k]=zpkdata(sys_1, 'v'); % 'v' è per la forma vettoriale

bode(sys_1);

[Gm,Pm,Wcg,Wcp] = margin(sys_1);
