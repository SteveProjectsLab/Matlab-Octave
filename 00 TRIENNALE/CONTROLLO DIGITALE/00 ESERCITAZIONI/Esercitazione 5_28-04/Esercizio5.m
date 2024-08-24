clear 
close all
clc

%Comando c2d che eprmette di calcolare serie ZOH e Campionatore

num= [10 1];
den1= [1 1];
den2= [2 1];

den= conv(den1, den2);

sys_c=tf(num, den);  %Sistema tempo continuo


%%
%Tempo Campionamento
%So che la costante di tempo più veloce è 1 (da s+1)

Tcampion= 1/10;     %Calcolo Tcampionamento come costante/10

%Oppure con [z,p,k]=zpkdata(sys_1, 'v') trovo il polo più veloce ( in -1)
%Ne calcolo l'inverso, quindi 1/1= 1 e lo divido per 10.

%%
% Calcolo serie ZOH e campionatore
sys_d = c2d(sys_c,Tcampion, 'zoh');   %Sistema tempo discreto


%%
%Calcolo relazione tra y e u del sistema tempo discreto

%SU QUADERNO !

%%
%Come utilizzare il controllore

%Se ho controllore e sistema da controllare, il collegamento NON è diretto:
%infatti il controllore non può essere abbastanza generale da pilotare
%tutti gli attuatori.

% C'è una SCHEDA DI ACQUISIZIONE DATI, che dicrimina che informazioniportare e fissa il tempo di campionamento
%Simulink permette nche di simulare la scheda, con i 
% TRIGGER SUBSYSTEM ,con:
% - ingresso
% - uscita
% - ingresso di trigger, che governa l'esecuzione di ciò che è dentro il subsystem

%Se clicco sul Subsystem, si apre e lo modifico

% In ingresso metto un clock, con fronti salita distanti Tcampion.

%Ad gni fronte di salita verrà eseguito

%Creo un pulse, che inserisco nell'ingresso di trigger
%Poi modifico il subsystem, inserendo una MATLAB function, che posso
%modificare


