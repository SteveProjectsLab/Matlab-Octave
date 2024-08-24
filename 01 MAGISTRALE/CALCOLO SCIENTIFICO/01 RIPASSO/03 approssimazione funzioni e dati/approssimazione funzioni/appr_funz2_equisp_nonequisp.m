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
ERR=[];      % vettore che conterrà gli errori

Mv=struct('cdata',{},'colormap',{});

scelta_nodi=menu('scegli i nodi di interpolazione',...
    'nodi equispaziati', 'nodi Chebyshev');

for n=1:25
        % calcolo i nodi di interpolazione 
    if scelta_nodi==1
        % (equispaziati)
        x=linspace(xa,xb,n+1)';
        % l'errore continua ad aumentare per causa delle oscillazioni agli estremi
        % dell'intervallo del polinomio interpolatore
        % con i nodi equispaziati il polinomio interpolatore non sta convergendo alla funzione da
        % approssimare
        
    elseif scelta_nodi==2
        % chebyshev
        % utilizzando invece i nodi cheb-gauss-lobatto il polinomio converge alla
        % funzione
        xs=-cos(pi*(0:n)/n); xs=xs'; % nodi su [-1,1]
        x=(xb-xa)/2*xs+(xa+xb)/2;  % nodi su [xa,xb]
    end

    y=f(x);
    %NB per n>= 20 devo usare la formula baricentrica
    % altrimenti la matrice X sarebbe mal condizionata

    if n<20
        X=vander(x);
        a=X\y;
        y1=polyval(a,x1);
            
    elseif n>=20
        y1=barycentric(x,y,x1);
    end

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
    %axis([0,0,1,2*pi])
    Mv(n)=getframe;
end
% rappresento graficamente l'andamento dell'errore nell'ordine
close all
figure(n+1)
semilogy((1:n), ERR, '-*','Linewidth',2)
grid on
xlabel('n')
ylabel('||f-p_n||_{inf}')
title('andamento dell''errore')


%set(0,'DefaultFigureWindowStyle','normal');
figure(20);
axis([-2*pi,2*pi,-2*pi,2*pi])
movie(Mv,1,1);







