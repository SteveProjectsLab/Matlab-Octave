%% voglio confrontare l'errore utilizzando la formula baricentrica o la matrice di Vonder Monde
figure(21)

clear 
close all
clc
set(0,'DefaultFigureWindowStyle','docked');

% devo approssimare la seguente funzione

f=@(x)1./(1+x.^2)
xa=-5;
xb=5;
x1=linspace(xa,xb,200);
f1=f(x1);    % valuto f nei nodi x1
ERR1=[];      
ERR2=[]; 


for n=1:70
    %utilizzo i nodi di chebychev
    xs=-cos(pi*(0:n)/n); xs=xs'; % nodi su [-1,1]
    x=(xb-xa)/2*xs+(xa+xb)/2;  % nodi su [xa,xb]
    
    y=f(x);
   
    X=vander(x);
    a=X\y;
    y1=polyval(a,x1);
        

    y2=barycentric(x,y,x1);


    % calcolo l'errore commesso utilizzando Vonder Monde
    err1=max(abs(f1-y1));   % err=norm(f1-y1,'inf')
    ERR1=[ERR1,err1];

    % calcolo l'errore commesso utilizzando Barycentric
    err2=max(abs(f1-y2));   % err=norm(f1-y1,'inf')
    ERR2=[ERR2,err2];


end
% rappresento graficamente l'andamento dell'errore nell'ordine
close all
figure(1)
semilogy((1:n), ERR1, '-*','Linewidth',2,'DisplayName','VM');hold on;
semilogy((1:n), ERR2, '-*','Linewidth',2,'DisplayName','Barycentric')
grid on
xlabel('n')
ylabel('||f-p_n||_{inf}')
legend('-DynamicLegend')
title('andamento dell''errore')








