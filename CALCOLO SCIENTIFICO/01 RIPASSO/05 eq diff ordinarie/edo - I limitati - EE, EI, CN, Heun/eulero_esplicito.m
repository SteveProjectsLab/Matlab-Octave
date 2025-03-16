clear
close all
clc
set(0,'DefaultFigureWindowStyle','docked')

% devo calcolare la soludione di questa edo usando EI
odefun=@(t,y)t-y; % f(t,y)
tspan=[-1,3];     % [t0,T]
y0=1;   % cond. iniziale y(-1)=1
h=0.1;  % passo di discretizzazione
Nh=fix((tspan(2)-tspan(1))/h); % n. di passi

% chiamo Eulero esplicito
[tn,un]=eulero_esp(odefun,tspan,y0,Nh);


%% rappresento la soluzione
figure(1); clf
plot(tn,un,'o--','DisplayName','soluzione numerica')
grid on
xlabel('t')
ylabel('u')

%% sol esatta 
yex=@(t)t-1+3*exp(-(t+1));
hold on
fplot(yex,tspan,'DisplayName','soluzione esatta')

legend('-dynamicLegend')

%% calcolo l'errore
err=max(abs(yex(tn)-un));
fprintf('h=%f,  errore=%e \n',h,err)

%h=0.100000,  errore=5.760300e-02 

%% ripeto l'esercizio per diversi valori di h

% es1bis. eqdiff

figure(2); clf
fplot(yex,tspan)
hold on
grid on
xlabel('t')
ylabel('u')

H=[1 0.5, 0.25, 0.1, 0.05, 0.025, 0.0125, 6.25e-3]; % 4 valori del passo di discretizzazione
Err=[];
for h=H
    if h<0.05 % ripulisco la figura ogni volta
        figure(2);clf
        fplot(yex,tspan)
        hold on
        grid on
    end
    Nh=fix((tspan(2)-tspan(1))/h); % n. di passi
    % chiamo Eulero esplicito
    [tn,un]=eulero_esp(odefun,tspan,y0,Nh);
    % disegno la soluzione numerica
    plot(tn,un,'o--','Displayname',['h=',num2str(h)])
    legend('-dynamiclegend')
    % calcolo l'errore
    err=max(abs(yex(tn)-un));
    Err=[Err,err];
    fprintf('h=%f,  errore=%e \n',h,err)
    pause
    
end

% h=0.100000,  errore=5.760300e-02 
% h=0.500000,  errore=3.536383e-01  
% h=0.250000,  errore=1.544196e-01 
% h=0.100000,  errore=5.760300e-02 
% h=0.050000,  errore=2.818056e-02 
% h=0.025000,  errore=1.394100e-02 
% h=0.012500,  errore=6.933891e-03 
% h=0.006250,  errore=3.457879e-03 

% noto che per h tendente a zero l'errore diminuisce

%% rappresento graficamente gli errori e mi confronto con l'andamento teorico
figure(3); clf
loglog(H,Err,'Linewidth',2,'Displayname','Err. EE')
legend('-dynamiclegend')
hold on
loglog(H,H,'Linewidth',2,'Displayname','H')
grid on
xlabel('h')
ylabel('errori')


% dal grafico posso osservare come l'errore rispetti l'andamento teorico