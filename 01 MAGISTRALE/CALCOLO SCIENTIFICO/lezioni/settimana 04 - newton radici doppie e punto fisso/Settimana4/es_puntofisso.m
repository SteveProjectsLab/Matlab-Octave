% es punto fisso

phi1=@(x)-1/4*x.^2+x+1/2;
phi2=@(x)-x.^2+x+2;
phi3=@(x)x/2+1./x;

figure(1); clf
fplot(phi1,[0.1,3],'Linewidth',2,'Displayname','phi_1(x)')
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
% osservo che |phi_1'(alpha)|< 1, quindi mi aspetto che il metodo di 
% punto fisso converga con ordine 1
% osservo che phi_2'(alpha)<-1, quindi non mi aspetto convergenza al punto
% fisso
% osservo che phi_3'(alpha)=0, quindi mi aspetto convergenza di ordine 2

%%
%chiamo puntofisso
x0=1;
tol=1e-12; 
kmax=50;
[alpha1,niter1,errori1]=puntofisso(phi1,x0,tol,kmax)
plot(alpha1,alpha1,'ro','Markerfacecolor','r')
[alpha2,niter2,errori2]=puntofisso(phi2,x0,tol,kmax)
plot(alpha2,alpha2,'k+','Markerfacecolor','k')
[alpha3,niter3,errori3]=puntofisso(phi3,x0,tol,kmax)
plot(alpha3,alpha3,'b*','Markerfacecolor','b')

%% rappresento il vettore degli errori
figure(2); clf
semilogy((0:niter1)',errori1,'DisplayName','err phi_1','Linewidth',2)
legend('-dynamiclegend')
hold on
semilogy((0:niter2)',errori2,'DisplayName','err phi_2','Linewidth',2)
semilogy((0:niter3)',errori3,'DisplayName','err phi_3','Linewidth',2)

grid on
xlabel('k')
ylabel('errori')

