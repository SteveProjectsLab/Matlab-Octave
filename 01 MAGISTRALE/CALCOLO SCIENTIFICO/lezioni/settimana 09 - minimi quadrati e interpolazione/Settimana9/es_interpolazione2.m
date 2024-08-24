% es2 interpolazione di funzioni (esempio di Runge)

% definisco i dati
f=@(x)1./(1+x.^2);
xa=-5; xb=5;

% definisco il vettore x1 per calcolare l'errrore e disegnare
x1=linspace(xa,xb,200);
% valuto f nei nodi x1
f1=f(x1);
ERR=[];  % vettore che conterra' gli errori al variare di n

scelta_nodi=menu('scegli i nodi di interpolazione',...
    'nodi equispaziati', 'nodi Chebyshev');
N=2:64; % vettore riga
for n=N
    % calcolo i nodi di interpolazione 
    if scelta_nodi==1
        % (equispaziati)
        x=linspace(xa,xb,n+1)';
    elseif scelta_nodi==2
        % chebyshev
        xs=-cos(pi*(0:n)/n); xs=xs'; % nodi su [-1,1]
        x=(xb-xa)/2*xs+(xa+xb)/2;  % nodi su [xa,xb]
    end

    % valuto f nei nodi di interpolazione
    y=f(x);
%     % calcolo l'interpolatore di Lagrange globale con matrice Vander
%     X=vander(x);
%     a=X\y;
%     % valuto il polinomio nei nodi x1
%     y1=polyval(a,x1);
% calcolo l'interpolatore di Lagrange globale con barycentric
      y1=barycentric(x,y,x1);

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
    pause(0.5)
end

%% rappresento in un grafico tutti gli errori
figure(2); clf
semilogy(N, ERR, '-*','Linewidth',2)
grid on
xlabel('n')
ylabel('||f-p_n||_{inf}')
