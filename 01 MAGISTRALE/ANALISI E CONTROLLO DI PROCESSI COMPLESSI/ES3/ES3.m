clear all
close all

% Scrivere uno script che permetta di calcolare e studiare il punto di eq. 
% per r=-0.2 e r=0.2
% Tracciare lo schema simulink e simulare il sistema nei due casi per x0=4

syms r_s x_s
f=r_s+x_s^2
% f è la forma generale del nostro sistema "incerto"

r=-1:0.2:1; % r contiene tutti i valori da -1 a 1 con passo 0.2
for j=1:length(r)
f1=subs(f,r_s,r(j)) 
% f1 è la contestualizzazione di f al caso specifico in r
xeq_s=solve(f1==0,x_s)
xeq_v=double(xeq_s) 
% contiene tutti gli equilibri (scalari) del sistema
J_s=jacobian(f1)
for i=1:length(xeq_v)
    if isreal(xeq_v(i))
        aval=eig(double(subs(J_s,x_s,xeq_v(i))))
        if aval<0 % il punto di eq. è stabile
            plot(r(j),xeq_v(i),'bo')
        else
            plot(r(j),xeq_v(i),'r*')
        end
        grid on
        hold on
    end
end
end

% lancio tutte le simulazioni e faccio il plot
figure
for j=1:length(r)
    % faccio la simulazione
    out=sim('es3_ACPC_sim')
    % dalla simulazione prendo i dati per fare il grafico
    plot(out.tout,out.x_sim)
    hold on
end





