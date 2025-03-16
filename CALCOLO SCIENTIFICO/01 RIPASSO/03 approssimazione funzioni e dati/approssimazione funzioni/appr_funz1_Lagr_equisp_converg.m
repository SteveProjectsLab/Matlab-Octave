clear
close all
clc

f=@(x) (x+2)/7.*cos(x)   % funzione da approssimare
a=0;
b=6;
x1=linspace(a,b,200);    % utilizzo nodi equispaziati

set(0,'DefaultFigureWindowStyle','docked');

f1=f(x1);    % valuto f nei nodi x1
ERR=[];      % vettore che conterrà gli errori

%% calcolo gli interpolatori di Lagrange GLobale
% come da consegna n=1,2...10

for n=1:10
    
    x=linspace(0,6,n+1)';
    y=f(x);

    X=vander(x)
    a=X\y;
    y1=polyval(a,x1);

    figure(n);
    plot(x1,f1,'Linewidth',2,'Displayname','f(x)')
    legend('-dynamiclegend','Location','northwest')
    hold on
    plot(x1,y1,'Linewidth',2,'Displayname','p_n(x)')
    plot(x,y,'ok','MarkerFaceColor','k','Displayname','nodi')
    grid on
    xlabel('x')
    ylabel('y')
    title(['n=',num2str(n)])

    % calcolo l'errore
    err=max(abs(f1-y1));   % err=norm(f1-y1,'inf')
    ERR=[ERR,err];
end
%% rappresento graficamente l'andamento dell'errore nell'ordine
figure(11)
semilogy((1:10), ERR, '-*','Linewidth',2)
grid on
xlabel('n')
ylabel('||f-p_n||_{inf}')
title('andamento dell''errore')


% l'errore sta tendendo a zero al crescere di n
% è un caso, potrebbe non sempre essere così con nodi equispaziati