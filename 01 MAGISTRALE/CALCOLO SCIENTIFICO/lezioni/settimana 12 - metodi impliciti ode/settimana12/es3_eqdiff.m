% es1ter. eqdiff
% definisco i dati
odefun=@(t,y)t-y; % f(t,y)
tspan=[-1,3]; % [t0,T]
y0=1; % cond. iniziale
% sol esatta 
yex=@(t)t-1+3*exp(-(t+1));
% dati per secanti
tol=1e-8; kmax=20;

figure(1); clf
fplot(yex,tspan)
hold on
grid on
xlabel('t')
ylabel('u')

H=[0.5, 0.25, 0.05, 0.025]; % 4 valori del passo di discretizzazione
Err=[];
for h=H
    Nh=fix((tspan(2)-tspan(1))/h); % n. di passi
    % chiamo CrankNicolson
    [tn,un]=cranknicolson(odefun,tspan,y0,Nh,tol,kmax);
    % disegno la soluzione numerica
    plot(tn,un,'o--','Displayname',['h=',num2str(h)])
    legend('-dynamiclegend')
    % calcolo l'errore
    err=max(abs(yex(tn)-un));
    Err=[Err,err];
    fprintf('h=%f,  errore=%e \n',h,err)

end

% rappresento graficamente gli errori e mi confronto con l'andamento
% teorico
figure(2); clf
loglog(H,Err,'Linewidth',2,'Displayname','Err. CN')
legend('-dynamiclegend')
hold on
loglog(H,H.^2,'Linewidth',2,'Displayname','H^2')
grid on
xlabel('h')
ylabel('errori')








