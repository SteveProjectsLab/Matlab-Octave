close all
clear all
clc

num = [10 1]*1000;
den1= [100 1];
den2= [0.1 1];

den = conv(den1,den2);

sys_G = tf (num,den);

Tc=0.001;

%Gzoh *sys_G

Gzoh =tf(1, [0.5*Tc 1]);% pade

%devo fare il sottosist analogico

Ga=Gzoh*sys_G

%ora devo progettare il controllore sul soott anal ga

% avvio sisotool Ga


%----------------------------------------------------------------------
%errore a regime = 0
%----------------------------------------------------------------------
 %metto integratore su G

   %guardo se ho un integratore in Ga, non c'è
% lo aggiungo in anello aperto ( L) che è C e Ga, lo aggiungo in C

%----------------------------------------------------------------------
% comportamento simile primo ordine ( PM>75)
%----------------------------------------------------------------------


%----------------------------------------------------------------------
% tempo di raggiungimento di un secondo
%----------------------------------------------------------------------


%----------------------------------------------------------------------
% a w=100 attenuato di almeno 30 dB
%----------------------------------------------------------------------




% dopo esporto C e lo converto
% da command window

% c=tf(c)
% save C_file C
% load 

load C_file;

% adesso discretizzo con tustin

Cd = c2d(C,Tc,'tustin');
%----------------------------------------------------------------------
%adesso devo simularlo con simulink

% apro simulink digitando simulink su command window

% guarda foto negli allegati

%----------------------------------------------------------------------

% adesso devo verificare il Tc

% 1) metodo -40 db rispetto al guadagno

bode(sys_G);
grid on;

% da bode vedo che sono a -40 quando w =100
Tc1 = (2*pi)/100

%2 la cost di tempo piu veloce è 0.1

Tc2 =0.1*0.1

%3 wc=10 *wt
    % wt =5/T con T=1
    % esce T=5 quindi
    % wc =50 
    % Tc =2pi/50

%4 specifica alta freq

  % wc= 2 pi/5 *100 

% concludo che andava bene

