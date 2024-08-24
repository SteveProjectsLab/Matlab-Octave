% es1. eqdiff
% definisco i dati
odefun=@(t,y)t-y; % f(t,y)
tspan=[-1,3]; % [t0,T]
y0=1; % cond. iniziale
h=0.1; % passo di discretizzazione

Nh=fix((tspan(2)-tspan(1))/h); % n. di passi
% chiamo Eulero esplicito
[tn,un]=eulero_esp(odefun,tspan,y0,Nh);

% disegno la soluzione numerica
figure(1); clf
plot(tn,un,'o--')
grid on
xlabel('t')
ylabel('u')

% sol esatta 
yex=@(t)t-1+3*exp(-(t+1));
hold on
fplot(yex,tspan)

% calcolo l'errore
err=max(abs(yex(tn)-un));
fprintf('h=%f,  errore=%e \n',h,err)



