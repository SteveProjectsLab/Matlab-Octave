clear all
close all
clc

% r è il parametro che può cambiare tra -1 e 1, per ogni valore di questo
% calcoliamo i punti di equilibrio, li studiamo, e li grafichiamo nel
% diagramma di biforcazione
% per fare ciò usiamo il toolbox simbolico di Matlab

syms r_s x % rs per dire che è simblico
f_s=r_s*(x-2)+(x-2)^2; %dx/dt = f(x,r) %fs che ha rs come simbolo
r=-1:0.1:1; % r varai da -1 a 1 con passo 0.1

% il diagramma di biforcazione ha in ascissa r e sulle ordinate i  
% punti di equilbrio

% il nostro script dovrà sostituire alla variabile simbolica il valore e
% calcolarne i punti di equilibrio, cioè le rafici di f=0

for i=1:length(r)
    f=subs(f_s,'r_s',r(i));%sostituisco in fs r(i) a rs
    xeq_s=solve(f==0);
    xeq=double(xeq_s);%per convertire da simboli a double reali
    J_s=jacobian(f);%per valutare i punti di equilibrio
    %NB essendo un sistema in R1 lo jacobiano è una funzione scalare in x,
    % per ogni pto di eq, calcolo gli autovalori di J_s
    %NB il suo valore sarà il valore di J_s autovalore essendo in R1
    for j=1:length(xeq)
        if(isreal(xeq(j))) 
               J=double(subs(J_s,'x', xeq(j)));
               % in questo caso non devo calcolare gli autoval
               if(J<0)%pto eq stabile
                   plot(r(i),xeq(j),'bo')% "o" stabile
               else
                   plot(r(i),xeq(j),'rx')% "x" non stabile
                   
               end
               hold on
               grid on
        end
    end
end