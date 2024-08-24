% esercizio 2 sulle quadrature

% dati
xa=0; xb=5;
f=@(x)1./(1+(x-2).^2);
Iex=atan(3)+atan(2); % integrale esatto

H=[]; Err=[];
for M=10:10:1000
    % approssimo l'integrale con pmedio composito / trapezi /simpson
    if metodo==1
        Iapp=pmedioc(f,xa,xb,M);
    elseif metodo==2
        x=linspace(xa,xb,M+1);
        Iapp=trapz(x,f(x));
    elseif metodo==3
        Iapp=simpsonc(f,xa,xb,M);
    end

    H=[H,(xb-xa)/M]; % valuto e salvo l'ampiezza degli intervallini
    Err=[Err,abs(Iex-Iapp)]; % valuto e salvo l'errore nella lista Err
end

% rappresento gli errori al variare di H
figure(1);clf
loglog(H,Err,'Linewidth',2,'DisplayName','errori')
legend('-dynamiclegend')
hold on
grid on
loglog(H,H.^2,'Linewidth',2,'DisplayName','H^2')
loglog(H,H.^4,'Linewidth',2,'DisplayName','H^4')
xlabel('H')
ylabel('errori')

%% esercizio 2bis sulle quadrature
metodo=menu('scegli la formula','pmedio','trapezi','simpson');
% dati
xa=0; xb=5;
f=@(x)sqrt(x);
% f(x)=sqrt(x) non e' di classe C2([0,5]), non vale piu' la stima del
% teorema
Iex=2/3*5^(3/2); % integrale esatto

H=[]; Err=[];
for M=10:10:1000
    % approssimo l'integrale con pmedio composito / trapezi /simpson
    if metodo==1
        Iapp=pmedioc(f,xa,xb,M);
    elseif metodo==2
        x=linspace(xa,xb,M+1);
        Iapp=trapz(x,f(x));
    elseif metodo==3
        Iapp=simpsonc(f,xa,xb,M);
    end
    H=[H,(xb-xa)/M]; % valuto e salvo l'ampiezza degli intervallini
    Err=[Err,abs(Iex-Iapp)]; % valuto e salvo l'errore nella lista Err
end

% rappresento gli errori al variare di H
figure(1);clf
loglog(H,Err,'Linewidth',2,'DisplayName','errori')
legend('-dynamiclegend')
hold on
grid on
loglog(H,H.^2,'Linewidth',2,'DisplayName','H^2')
loglog(H,H.^4,'Linewidth',2,'DisplayName','H^4')
xlabel('H')
ylabel('errori')