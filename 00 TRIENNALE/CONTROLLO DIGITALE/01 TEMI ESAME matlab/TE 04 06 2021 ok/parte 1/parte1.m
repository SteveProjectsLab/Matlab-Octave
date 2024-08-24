close all 
clear all
clc
%------------------------------------------------------------------------
% inserisco il sistema G(s)

num=100*[100 1];
den1=[10 1];
den2=[0.1 1];
den = conv(den1,den2);

G=tf(num,den)
%------------------------------------------------------------------------
% sottosistema analogico
Tc=0.001;
Gzoh= tf(1, [0.5*Tc 1])
Ga= G*Gzoh
%------------------------------------------------------------------------
% sintesi del controllore (partendo da Ga) con sisotool

% controlSystemDesigner(Ga); % da command window

% DEVO RISPETTARE LE SPECIFICHE
% 1. errore a regime a fronte di set point a scaluno = 0
    % devo inserire un integratore in L(s),in C, nel caso che non ci sia
    % già in ga
   
% 2. il sistema retroazionato deve avere un comportamento come 1°ordine
    % per fare ciò devo avere PM>75°
% 3. raggiungimento del valore a regime in 1s
    %dato che sono a PM>75
    %T=1s = 5*cost tempo 
    %polo =-1/cost tempo
    %wt = 5/T=5 deve essere maggiore

% 4. sovraelongazione massima del 5%
    % PM =100*smorzamento
    % dal grafico 5% corrisponde a uno smorzamento di 0.75
    % PM =100*0.75=75

% 5. a w=100 il disturbo deve essere a -35dB
       

% REALIZZO IL CONTROLLORE CONSISOTOOL

%aggiungo un integratore, rispetto la specifica 1
% parto da sinistra, ho uno zero che mi fa pendere troppo poco ilmodulo
% aggiungo quindi un polo dalle sue parti per cancellare l'effetto dello
% zero
% poi ho un polo in 0.1, lo compenso con uno zero
% modifico il guadagno per rispettare il margine di fase
% ottengo così PM=78 e wt=10 , rispetot le specifiche 2,3,4
% aggiungo due poli tra wt e w=100 per far si che a w=100 sia a -35dB
%------------------------------------------------------------------------
% da command window:
% converto      C=tf(C)
% salvo         saveCfile c
load C_file;    % carico il 

% discretizzo il controllore con tustin
C_d= c2d(C, Tc, 'tustin');
%------------------------------------------------------------------------
% apro simulink e simulo il sistema retroazionato controllato