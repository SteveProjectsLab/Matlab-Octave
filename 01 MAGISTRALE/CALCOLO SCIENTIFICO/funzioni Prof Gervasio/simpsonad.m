function [isa, nodi]=simpsonad(f,a,b,tol,hmin)
% formula di quadratura di Simpson adattiva
% Input: f = function handle della funzione integranda
%        a,b = estremi intervallo di itnegrazione
%        tol = tol per l'errore : |I -Isa|< tol
%        hmin = ampiezza minima contemplata degli intervallini
% Output: isa = integrale calcolato
%         nodi= vettore con tutti in nodi utilizzati per approx
%         l'integrale

% inizializzazioni
alpha=a;
beta=b;
isa=0;
nodi=[];
while (beta-alpha)> 0
  I1=simpsonc(f,alpha,beta,1); % integrale su [alpha,beta] con M=1
  I2=simpsonc(f,alpha,beta,2); % integrale su [alpha,beta] con M=2
  stimatore=abs(I1-I2)/15; % stimatore dell'errore
  
  if stimatore > tol/2*(beta-alpha)/(b-a) && (beta-alpha)> hmin
  % l'integrale e' scarso e non ho raggiunto hminimo
  % dimezzo l'intervallo attivo
  beta=(beta+alpha)/2; 
  else
    % accetto I2 
    isa=isa+I2;
    nodilocali=linspace(alpha,beta,5); % vettore riga
    nodi=[nodi,nodilocali];
    % modifico alpha e beta
    alpha=beta;
    beta=b;
  end
end
nodi=unique(nodi);
