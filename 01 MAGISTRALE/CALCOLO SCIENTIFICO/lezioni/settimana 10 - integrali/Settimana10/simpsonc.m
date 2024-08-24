function Is=simpsonc(f,a,b,M)
% simpsonc: approssimo l'integrale di f su [a,b] con simpson comp.
% su intervalli di uguale ampiezza
% Is=simpsonc(f,a,b,M)
% Input: f= function handle della funzione integranda
%        a,b = estermi dell'intervallo di integrazione
%        M = numero di intervalli per la formula composita
% Output: Is = integrale calcolato

H=(b-a)/M; % ampiezza di ogni intervallino
% genero i punti che individuano gli intervallini
x=linspace(a,b,M+1);

Is=0;
for k=2:M+1
    Is=Is+( f(x(k-1)) + 4*f((x(k-1)+x(k))/2) + f(x(k)) );
end

Is=Is*H/6;
