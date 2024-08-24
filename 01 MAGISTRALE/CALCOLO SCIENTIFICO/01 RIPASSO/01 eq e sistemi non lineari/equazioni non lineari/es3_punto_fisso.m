clear all
close
clc
set(0,'DefaultFigureWindowStyle','docked')
% voglio approssimare il valore radice di due

f=@(x)x^2-2%=0
df=matlabFunction(diff(sym(f),1)) % df= x^2


%%
%--------------------------------------------------------------------------
%dire se le funzioni di punto fisso proposte sono adeguate per il calcolo
phi1=@(x)-1/4*x.^2+x+1/2;
phi2=@(x)-x.^2+x+2;% +- x
phi3=@(x)x/2+1./x;

%NB come prima cosa devo verificare che le 3 funzioni ammettano il punto
%fisso desiderato.

phi1(sqrt(2))% 1.4142 ok
phi2(sqrt(2))% 1.4142 ok
phi3(sqrt(2))% 1.4142 ok

figure(1); 
fplot(phi1,[0.1,3],'Linewidth',2,'Displayname','phi_1(x)');%mygrid();
legend('-dynamiclegend')
hold on
fplot(@(x)x,[0.1,3]) % disegno la bisettrice
fplot(phi2,[0.1,3],'Linewidth',2,'Displayname','phi_2(x)')
fplot(phi3,[0.1,3],'Linewidth',2,'Displayname','phi_3(x)')

% retta con pendenza =-1 e passante per (sqrt(2),sqrt(2))
% y(x)=m(x-sqrt(2))+sqrt(2)
retta=@(x)-1*(x-sqrt(2))+sqrt(2);
fplot(retta,[0.1,3]) % disegno la retta

grid on
axis equal
axis([0.1,3,0.1,3])


% osservo il modulo dele derivate in un intorno della radice
dphi1=matlabFunction(diff(sym(phi1),1));
abs(dphi1(sqrt(2)))   % 0.2929

dphi2=matlabFunction(diff(sym(phi2),1));
abs(dphi2(sqrt(2)))   % 1.8284

dphi3=matlabFunction(diff(sym(phi3),1));
abs(dphi3(sqrt(2)))   % 1.1102e-16

% osservo che |phi_1'(alpha)|< 1, quindi mi aspetto che il metodo di 
% punto fisso converga con ordine 1
% osservo che phi_2'(alpha)<-1, quindi non mi aspetto convergenza al punto
% fisso
% osservo che phi_3'(alpha)=0, quindi mi aspetto convergenza di ordine 2


%--------------------------------------------------------------------------
% devo verificare numericamente ciò che è appena stato detto.


x0=1;
tol=1e-12; 
kmax=50;
[alpha1,niter1,xv1,errori1]=ptofisso(phi1,x0,tol,kmax)
plot(alpha1,alpha1,'ro','Markerfacecolor','r')
[alpha2,niter2,xv2,errori2]=ptofisso(phi2,x0,tol,kmax)
plot(alpha2,alpha2,'k+','Markerfacecolor','k')
[alpha3,niter3,xv3,errori3]=ptofisso(phi3,x0,tol,kmax)
plot(alpha3,alpha3,'b*','Markerfacecolor','b')


% rappresento le successioni
figure(2);
plot((0:niter1),xv1,'Displayname','phi_1(x)');hold on;mygrid();
plot((0:niter3),xv3,'Displayname','phi_3(x)');hold on;mygrid();
plot((0:niter2),xv2,'Displayname','phi_2(x)');hold on;mygrid()
legend('-dynamiclegend')
% si può vedere come la successione 2 non converga, mentre la 1 e la 3 si


% rappresento il vettore degli errori
figure(3); clf
semilogy((0:niter1)',errori1,'DisplayName','err phi_1','Linewidth',2)
legend('-dynamiclegend')
hold on
semilogy((0:niter2)',errori2,'DisplayName','err phi_2','Linewidth',2)
semilogy((0:niter3)',errori3,'DisplayName','err phi_3','Linewidth',2)

grid on
xlabel('k')
ylabel('errori')

% dal grafico posso notare come l'errore per phi 2 rimanga costante
% mentre per phi1 decresca linearmente
% per phi3 decresca quadraticamente

% se utilizzassi il metodo di newton per risolvere il sistema
% phi 3 problwma di punto fisso coinciderebbe con il metodo di NW

% dato che 
% f= x^2-2x
% df=2x

% newton=> x^(k+1)=x-f(x)/f'(x)
% phi3=x/2+1/x;

% quindi phi3 = newton


