% Sallen key ,second order, low pass filter 
close all
clear
clc

set(0,'DefaultFigureWindowStyle','docked');
% dati sperimentali
ampiezza_in=0.1.*[2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2];
ampiezza_out=0.001.*[7.8,16.2,40,76,105,118,124,134,142,154,180,192,198,200,200,200,199,199,198,198];
fase_deg=[88.3,88.3,78.5,67.3,58.1,53.1,50,48.1,44.2,39.2,26.2,14,6.91,3.24,1.44,0.864,0.540,0.540,0.288,0.359]
fase_rad= fase_deg*(pi/180);
frequenza=[1,2,5,10,15,18,20,22,25,30,50,100,200,500,1e3,2e3,5e3,1e4,5e4,5e5];
% length(ampiezza_out)
% length(ampiezza_in)
% length(frequenza)
length(fase_deg)
figure (100)
semilogx(frequenza,20*log(ampiezza_out./ampiezza_in),'o-','MarkerFaceColor','r','MarkerEdgeColor','r')
grid on
figure(101)
semilogx(frequenza,fase_deg,'o-','MarkerFaceColor','r','MarkerEdgeColor','r')
grid on

%%

% parametri
R=82e3
C=100e-9
tau=R*C

% funzione di trasferimento
s=tf('s');
H=(tau*s)/(1+tau*s)

w0=1/tau;
f0=w0/(2*pi)

[mag, phase, wout] = bode(H);
mag = squeeze(mag);
phase = squeeze(phase);

% diagrammi di Bode, modulo e fase
figure(1);

plotoptions = bodeoptions;
plotoptions.Grid = 'on';
plotoptions.FreqUnits = 'Hz';

plot=bodeplot(H,plotoptions)

