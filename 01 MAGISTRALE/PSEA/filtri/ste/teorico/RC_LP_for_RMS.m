% Sallen key ,second order, low pass filter 
close all
clear
clc

set(0,'DefaultFigureWindowStyle','docked');


% parametri
R=510
C=100e-6
tau=R*C

% funzione di trasferimento
s=tf('s');
H=1/(1+tau*s)

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
hold on
line(xlim, [-18 -18],'color','k','DisplayName','-3dB','lineStyle','--'); 
% %%
% % hold on
% h = bodeplot(H,20e3,'')
% 
% [mag,phase] = bode(H,20e3)
% plot([mag,phase],'or','MarkerFaceColor','r')
% %[mag,phase,wout] = bode(H,20k) 
% title('Bode diagram of Sallen Key filter')
