close all
clear all
clc

num= [10 1];
den= conv([100 1],[0.1 1])

G=tf(num,den)

Tc=0.001;

%Gzoh *sys_G

Gzoh =tf(1, [0.5*Tc 1])% pade

%devo fare il sottosist analogico

Ga=Gzoh*G

% errore a regime = 0
    % aggiungo un integratore a C
    % aggiungo uno zero al polo in 10^2
    % aggiungo uno zero a 10
    % il margine di fase è sballato ed è lento
    % aggiungo un polo in 0,1
    % ho una frequenza di taglio sballata
    % guadagno

% tempo 1s
    % T=5*cost piu veloce
    % cost veloce = T/t=0.2
    % ricavo wt = 1/cost veloce = 5
    % wt >=5
    % disturbo a w =100 a -30dB

load C_file C

Cd = c2d(C,Tc,'tustin')

% 1. 0.1/10
guadagno=dcgain(G)
bode(G)
[z,p,k]=zpkdata(G,'v')
% 2. a w=100 è a -40db
%2pi/100
% omega taglio
%2pi/50
% 4.
%2pi/500 = 0,01


%il prof ci da Tc =0,001 che è < di tutte e 4       - >      ok

