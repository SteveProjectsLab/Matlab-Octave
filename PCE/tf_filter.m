# in mancanza del package installarlo col seguente comando:
#pkg install -forge symbolic

clc
clear
close all
pkg load symbolic
pkg load control

#-------------------------------------------------------------------------------
#   filtro HP U19
#-------------------------------------------------------------------------------
syms R1 R2 C Vin Vout I s H

eqn1= Vin== R1*I+I*R2;
Zp=(R2/(C*s))/(R2+1/(C*s))
eqn2= Vout==Vin*Zp/(R1+Zp)
eqn3= H == Vout/Vin;

result= solve([eqn1,eqn2,eqn3],[Vin,I,Vout,H]);

H=collect(result.H,s)
##H = (sym)
##
##             R2
##  -------------------------
##  C*R2*R1*s + R2 + R1



% inserisco i valori dei componenti
H_num=subs(H,{R1,R2,C},{20e3,20e3,100e-9})
##H_num = (sym)
##
##     20000
##  ------------
##  40*s + 40000


# bisogna scrivere la funzione di trasferimento a mano
#( non si riesce a convertire automaticamente da sym o fun al formato tf)
figure(1)
s=tf('s')
g=(20e3/(40*s+40e3))
bode(g)

clear all

