function [tt,un] = multiste2(odefun,tspan,y0,Nh)
%
% Risoluzione problema di Cauchy y' = f(t,y) con
%  il metodo multistep u_{n+1}=u_n+h/12*(23f_n-16f_{n-1}+5f_{n-2})
%    function [tn,un] = multiste2(odefun,tspan,y0,Nh)
%
%   Input: 
%          odefun = funzione del problema di Cauchy, definita con @
%            Puo' essere una funzione scalare
%            od una funzione vettoriale. Nel caso di funzione vettoriale,
%            per t scalare e y vettore, odefun(t,y) deve ritornare un vettore 
%            colonna della stessa dimensione di y.
%          tspan=[t0,T] = istanti iniziale e finale dell'intervallo tempo
%          y0 = condizione iniziale (vettore colonna se si risolve un sistema)
%
%          Nh= numero di passi di discretizzazione (costante)
%          
%   Output: tt =vettore colonna con i nodi di discretizzazione
%           un = array contenente le componenti della soluzione 
%                numerica. Su ogni riga di un c'e' una componente della
%                soluzione (se questa e' di tipo vettoriale)
%



tt=linspace(tspan(1),tspan(2),Nh+1);
h=(tspan(2)-tspan(1))/Nh;

un(:,1) = y0;
hmezzi=h*0.5; h34=h*0.75; h9=h/9;
% calcolo il secondo e il terzo dato iniziale 
for n=1:2
K1=odefun(tt(n),un(n,:)'); 
K2=odefun(tt(n)+hmezzi,un(n,:)'+hmezzi*K1);
K3=odefun(tt(n)+h34,un(n,:)'+h34*K2);
un(n+1,:) = un(n,:) + h9*(2*K1+3*K2+4*K3)';
end
f1=odefun(tt(1),un(1,:)');
f0=odefun(tt(2),un(2,:)');

for n = 3:Nh
    f2=f1;f1=f0;
    f0=odefun(tt(n),un(n,:)');
un(n+1,:) = un(n,:) + h/12*(23*f0-16*f1+5*f2)';
end

tt=tt';
