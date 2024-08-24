
clear
close all
clc

dt=0.01;
t=-10:dt:10;
dtau=0.01
tau=-15:dtau:15;

x=rect(t);
y=1j*tri(t+1);
p = rect(t-0.5) - rect(t-1.5);

%calcolare crosscorrelazione e autocorrelazione
AutoCorrelazione=zeros(length(tau));
CorrelazioneXY=zeros(length(tau));
CorrelazioneXY2=zeros(length(tau));
AutoCorrelazionep=zeros(length(tau));
% non traslare ma col for prendo tutti i valori di traslazione di tau
for k=1:length(tau);
    xtau=rect(t+tau(k));
    AutoCorrelazione(k)=myCorrelazioneLin(x,xtau,dt);
    
    ytau=tri(t+tau(k)+1);
    CorrelazioneXY(k)=myCorrelazioneLin(x,ytau,dt);
    ytau2=1j*tri(t+tau(k)+1);
    CorrelazioneXY2(k)=myCorrelazioneLin(x,ytau2,dt);
    ptau=rect(t-0.5+tau(k)) - rect(t-1.5+tau(k));
    AutoCorrelazionep(k)=myCorrelazioneLin(p,ptau,dt);
end


figure('Name','Autocorrelazione di x= rect(t)','NumberTitle','off'),set(1, 'WindowStyle', 'docked')
plot(tau,AutoCorrelazione),grid on
figure('Name','Cross-correlazione(x=rect,y=tri(t+1))','NumberTitle','off'),set(2, 'WindowStyle', 'docked')
plot(tau,CorrelazioneXY),grid on
figure('Name','Cross-correlazione(x=rect,y=j*tri(t+1))','NumberTitle','off'),set(3, 'WindowStyle', 'docked')
plot(tau,imag(CorrelazioneXY2));%utilizzo imag perchè è un segnale immaginario
figure('Name','Cross-correlazioneultimo segnale della consegna','NumberTitle','off'),set(4, 'WindowStyle', 'docked')
plot(tau,AutoCorrelazionep),grid on





