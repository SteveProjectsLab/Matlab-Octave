% es1 interpolazione di funzioni

% definisco i dati
f=@(x)(x+2)/7.*cos(x);
xa=0; xb=6;

% definisco il vettore x1 per calcolare l'errrore e disegnare
x1=linspace(xa,xb,200);
% valuto f nei nodi x1
f1=f(x1);
ERR=[];  % vettore che conterra' gli errori al variare di n
for n=1:10
    % calcolo i nodi di interpolazione (equispaziati)
    x=linspace(xa,xb,n+1)';
    % valuto f nei nodi di interpolazione
    y=f(x);
    % calcolo l'interpolatore di Lagrange globale con matrice Vander
    X=vander(x);
    a=X\y;
    % valuto il polinomio nei nodi x1
    y1=polyval(a,x1);

    % rappresento graficamente f, i nodi di interpolazione eil pol.
    figure(1); clf
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
    pause
end

%% rappresento in un grafico tutti gli errori
figure(2); clf
semilogy((1:10), ERR, '-*','Linewidth',2)
grid on
xlabel('n')
ylabel('||f-p_n||_{inf}')
