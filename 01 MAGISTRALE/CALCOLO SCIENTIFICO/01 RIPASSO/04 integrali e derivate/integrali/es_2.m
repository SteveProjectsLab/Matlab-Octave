clear
close all
clc
% devo calcolare l'integrale di f su I=[xa,xb]
xa=0;
xb=5;
f=@(x)1./(1+(x-2).^2);  
fplot(f,[-3,6])
%%
%calcolo l'integrale esatto indefinito
Iex=int(sym(f)) %=atan(x - 2)
% calcolo l'integrale esatto definito
Iex=atan(xb-2)-atan(xa-2) %= 2.356194490192345e+00

H=[]; Err=[];
%calcolo l'integrale numericamente
for M=10:10:1000
    % approssimo l'integrale con pmedio composito / trapezi /simpson
    Iapp=pmedioc(f,xa,xb,M);
    H=[H,(xb-xa)/M]; % valuto e salvo l'ampiezza degli intervallini
    Err=[Err,abs(Iex-Iapp)]; % valuto e salvo l'errore nella lista Err
end

figure(1)
loglog(H,Err,'Linewidth',2,'DisplayName','errori')
legend('-dynamiclegend');hold on;grid on;
loglog(H,H.^2,'Linewidth',2,'DisplayName','H^2')
loglog(H,H.^4,'Linewidth',2,'DisplayName','H^4')
xlabel('H')
ylabel('errori')

% calcolo l'integrale approssimato nel caso M=1000
M=1000
    Iapp=pmedioc(f,xa,xb,M)
    H=(xb-xa)/M
    Err=abs(Iex-Iapp)
% M = 1000
% Iapp = 2.356194 719358795e+00
% I ex = 2.356194 490192345e+00
% H = 5.000000000000000e-03
% Err =     2.291664498166313e-07

% dal grafico vedo che gli errori hanno una pendenza simile a quella di H^2

%% ripeto utilizzando trapezi composita e simpson composita
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

if metodo==1
    title('punto medio')
elseif metodo==2
    title('trapezi')
elseif metodo==3
    title('Simpson')
end
