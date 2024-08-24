function [tn,un]=eulero_esp_sys(odefun,tspan,y0,Nh)
% eulero_esp_sys: metodo di Eulero esplicito per l'appx di sistemi di edo
%  [tn,un]=eulero_esp_sys(odefun,tspan,y0,Nh)
% Input: odefun = function handle di f(t,y)
%        tspan = [t0, T] vettore con istante iniziale e finale
%        y0 = condizione iniziale del p. di Cauchy
%        Nh = numero di passi temporali
% Output: tn = vettore colonna dei tempi
%         un = matrice della soluzione numerica, 
%              ogni colonna contiene una componente della soluzione
%              del sistema

y0=y0(:); % y0 viene convertito sempre in vettore colonna

% da y0 leggo il numero di equazioni
d=length(y0); 

% h = passo temporale
h=(tspan(2)-tspan(1))/Nh;

% vettore dei tempi
tn=linspace(tspan(1),tspan(2),Nh+1)';
% vettore soluzione
un=zeros(Nh+1,d);

un(1,:)=y0.'; % .' realizza la trasposta anche sui complessi
% ' farebbe complesso coniugato

for n=1:Nh
    wn=un(n,:).';
    w=wn+h*odefun(tn(n),wn);
    un(n+1,:)=w.';
end
