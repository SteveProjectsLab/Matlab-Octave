clear
close all
clc

dt=0.01;
t=-10:dt:10;

dtau=dt;
tau=-15:dtau:15;

df=0.01;
f= -15:df:15;

x=sinc(t);

Campionamento_InterpolazioneIdeale(x, 10, 25, 100, t, f, 1);

Campionamento_Mantenimento(x, 10, 25, 100, t, f, 7);

Campionamento_InterpolazioneLineare(x, 10, 25, 100, t, f, 13);

