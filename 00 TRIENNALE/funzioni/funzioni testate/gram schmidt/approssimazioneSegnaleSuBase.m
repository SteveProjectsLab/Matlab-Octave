function approx_x = approssimazioneSegnaleSuBase(x,Base, dim, t)
%APPROSSIMAZIONESEGANLESUBASE 
%   Funzione che calcola l'approssimazione di un segnale su una base
%   fornita di dimensione dim

dt=t(2)-t(1);
approx_x=zeros(1, length(x));

for k=1:dim
    alpha= myScalarProduct(x, Base(k,:),dt);
    approx_x= approx_x + alpha*Base(k,:);
    %Crea una funzione a gradini che approssima la funzione originale
end

figure
plot( t, approx_x, t, x)  %stampo entrambi i segnali per confrontarli
end

