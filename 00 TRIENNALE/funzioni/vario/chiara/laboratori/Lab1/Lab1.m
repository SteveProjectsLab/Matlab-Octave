clear
close all
clc


dt=0.01;
t=-10:dt:10;
e=0.1;

x1=4*rect((t-3)/10);
x2=3*tri((t+1)/4);
x3=e*(-t+1);
figure        %mi permette di tenere aperte più finestre contemporaneamente
plot(t, x1, 'r --', t, x2,':', t, x3)
%Posso realizzare la stessa cosa con :
%plot(t, x1, 'r --')
%hold on
%plot(t, x2,':')
%hold on
%plot(t, x3)



x4=x1+2*x2+3*x3;
x5=x1.*x2.*x3;
figure
plot(t, x4, t, x5)


x6=sin(t);
x7=cos(2*pi*t);
figure
plot(t, x6,'r', t, x7, 'b' )
x8=x6.*x7;
x9= x6+x7;
figure
plot( t, x8, 'r', t, x9, 'b')

