clear
close all
clc

set(0,'DefaultFigureWindowStyle','docked')


% es interpolazione3
% dati
f=@(x)1./(x.^2+1);
xa=-5; xb=5;
% vettore x1 dei punti piu' fitti necessari per disegnare e calcolare
% l'errore
x1=linspace(xa,xb,2000)';
% valuto la f nei punti x1
f1=f(x1);
% vettori per rappresentare l'errore al variare di H
ERR=[]; H=[];
for n=10:10:500
    % devo definire i vettori x e y necessari all'interpolazione
    x=linspace(xa,xb,n+1)';
    y=f(x);


    % valuto p1c nei nodi x1
            y1=interp1(x,y,x1);



    % valuto la spline cubica
            %y1=spline(x,y,x1);



    % disegno
    if n <=100
        figure(1);clf
        plot(x1,f1,'linewidth',2,'Displayname','f(x)')
        legend('-dynamiclegend')
        hold on
        plot(x1,y1,'LineWidth',2,'DisplayName','p_1^c(x)')
        grid on
        xlabel('x')
        ylabel('y')
        title(['n = ',num2str(n)])
        pause(0.4)
    end
    % calcolo l'errore
    err=norm(y1-f1,'inf');
    H=[H,(xb-xa)/n];
    ERR=[ERR,err];
end

%% disegno l'andamento dell'errore al variare di H
figure(2); 
loglog(H,ERR,'Linewidth',2,'DisplayName','errore','Color','k')
legend('-dynamiclegend')
hold on

loglog(H,H,'Linewidth',2,'DisplayName','H')
loglog(H,H.^2,'Linewidth',2,'DisplayName','H^2')
loglog(H,H.^3,'Linewidth',2,'DisplayName','H^3')
loglog(H,H.^4,'Linewidth',2,'DisplayName','H^4')

grid on
xlabel('H')
ylabel('errore')

% l'errore per quanto riguarda la spline cubica è dell'ordine H^2
% mentre per quanto riguarda la spline l'ordine H^4
