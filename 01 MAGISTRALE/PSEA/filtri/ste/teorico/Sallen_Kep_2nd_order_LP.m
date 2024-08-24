% Sallen key ,second order, low pass filter 
close all
clear
clc
set(0,'DefaultFigureWindowStyle','docked');


% parametri
R1=20e3
R2=1e3
C1=4.7e-9
C2=550e-12
K=1

% funzione di trasferimento
s=tf('s');
H=K*1/(R1*C1*R2*C2*s^2+((1-K)*R1*C1+R1*C2+R2*C2)*s+1)

w0=1/(sqrt(R1*C1*R2*C2));
f0=w0/(2*pi)
Q=1/((1-K)*sqrt((R1*C1)/(R2*C2))+sqrt((R1*C2)/(R2*C1))+sqrt((R2*C2)/(R1*C1)))

[mag, phase, wout] = bode(H);
mag = squeeze(mag);
phase = squeeze(phase);


% diagrammi di Bode, modulo e fase
figure(1);

plotoptions = bodeoptions;
plotoptions.Grid = 'on';
plotoptions.FreqUnits = 'Hz';

plot=bodeplot(H,plotoptions);
% %%
% % hold on
% h = bodeplot(H,20e3,'')
% 
% [mag,phase] = bode(H,20e3)
% plot([mag,phase],'or','MarkerFaceColor','r')
% %[mag,phase,wout] = bode(H,20k) 
% title('Bode diagram of Sallen Key filter')
