
%                           03/03/2022


%                           MOLARI STEFANO 727197

clear
close all
clc

% inserisco sistema G1

num_G1 = [10];
den_1_G1 = [1 1];
den_2_G1 = [1/100 1];
den_G1 = conv(den_1_G1,den_2_G1);

sys_G1= tf(num_G1,den_G1);


% inserisco sistema G2

num_G2 = [10];
den_1_G2 = [1 10];
den_2_G2 = [1 100];
den_G2 = conv(den_1_G2,den_2_G2);

sys_G2= tf(num_G2,den_G2);

% inserisco sistema G3

sys_G3= sys_G1*sys_G2;

% calcolo poli, zeri e guadagno di G1,G2,G3

[z1,p1,k1]=zpkdata(sys_G1,'v')
[z2,p2,k2]=zpkdata(sys_G2,'v')
[z3,p3,k3]=zpkdata(sys_G3,'v')

% calcolo guadagno G1,G2,G3

guadagno_G1 = dcgain(sys_G1)
guadagno_G2 = dcgain(sys_G2)
guadagno_G3 = dcgain(sys_G3)

%calcolo PM e GM di G1,G2,G3
[Gm1,Pm1,Wcg1,Wcp1] = margin(sys_G1)
[Gm2,Pm2,Wcg2,Wcp2] = margin(sys_G2)
[Gm3,Pm3,Wcg3,Wcp3] = margin(sys_G3)

% traccio i diagrammi di Bode(reale) e di Nyquist di G1,G2,G3
figure(1)
subplot(1,2,1)
bode(sys_G1)
subplot(1,2,2)
nyquist(sys_G1)

figure(2)
subplot(1,2,1)
bode(sys_G2)
subplot(1,2,2)
nyquist(sys_G2)

figure(3)
subplot(1,2,1)
bode(sys_G3)
subplot(1,2,2)
nyquist(sys_G3)

%--------------------------------------------------------------------------

% 1. Indicare quali dei sistemi aventi le seguenti caratteristiche 
% sono stabili in ANELLO APERTO:
% 1. Poli in (-1,-2) e PM=10°      -    STABILE 
% 2. Poli in (-1,-2) e PM=-10°     -    STABILE, ( non mi interessa PM)
% 3. Poli in (-1,1) e PM=90°       -    INSTABILE, ha polo >0

%--------------------------------------------------------------------------

% 2. Indicare quali dei sistemi aventi le seguenti caratteristiche 
% sono stabili in anello chiuso:
% 1. Poli in (-1,-2) e PM=10°       -   STABILE
% 2. Poli in (-1,-2) e PM=-10°      -   INSTABILE, PM<0
% 3. Poli in (-1,1) e PM=90°        -   NON POSSO APPLICARE BODE, NON SO
                                     %  PERCHE' NON è UN SISTEMA STABILE 
                                     %  IN ANELLO AAPERTO

