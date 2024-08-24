function Ipm=pmedioc(f,a,b,M)
% pmedioc: approssimo l'integrale di f su [a,b] con p medio comp.
% su intervalli di uguale ampiezza
% Ipm=pmedioc(f,a,b,M)
% Input: f= function handle della funzione integranda
%        a,b = estermi dell'intervallo di integrazione
%        M = numero di intervalli per la formula composita
% Output: Ipm = integrale calcolato

H=(b-a)/M; % ampiezza di ogni intervallino
% genero i punti che individuano gli intervallini
x=linspace(a,b,M+1);

Ipm=0;
for k=2:M+1
    Ipm=Ipm+f((x(k-1)+x(k))/2);
end

Ipm=Ipm*H;
