clear
close all
clc

%% calcolo dell'integrale numerico e quello esatto
for M=10:10:1000
    % approssimo l'integrale con pmedio composito / trapezi /simpson
    Iapp=pmedioc(f,xa,xb,M);

    % x=linspace(xa,xb,M+1);
    % Iapp=trapz(x,f(x));

    %Iapp=simpsonc(f,xa,xb,M);

    % calcolo l'errore commesso
    H=[H,(xb-xa)/M]; % valuto e salvo l'ampiezza degli intervallini
    Err=[Err,abs(Iex-Iapp)]; % valuto e salvo l'errore nella lista Err
end

%% fdq gaussiane ( riguarda) 

%% trovare Hmax e Mmin per commettere un errore minore di 
% pongo l'errore uguale alla richiesta, risolvo la disequazione ( con err a
% destra) e trovo Hmax
Hmax=sqrt((err*24)/((b1-a1)*(maxd2f1)))
Hmax=sqrt((err*12)/((b1-a1)*(maxd2f1)))
Hmax=power((err*18*160)/((b1-a1)*(maxd4f1)),1/4)
M_min=ceil((b1-a1)/Hmax)

%% rappresentare l'errore

figure(2)
loglog(H,Err,'Linewidth',2,'DisplayName','errori')
legend('-dynamiclegend');hold on;grid on;
loglog(H,H.^2,'Linewidth',2,'DisplayName','H^2')
loglog(H,H.^4,'Linewidth',2,'DisplayName','H^4')
xlabel('H')
ylabel('errori')