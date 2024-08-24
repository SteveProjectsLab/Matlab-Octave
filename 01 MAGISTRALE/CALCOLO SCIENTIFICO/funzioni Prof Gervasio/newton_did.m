function [z,res,k]=newton_did(f,df,x0,tol,kmax,a,b)
% metodo di Newton per risolvere f(x)=0 con plot delle rette tangenti
% Input: f = function handle della funzione f
%        df =  function handle della derivata prima di f
%        x0 = punto iniziale 
%        tol = tolleranza per il test d'arresto
%        kmax = numero massimo di iterazioni
%        a,b= estremi dell'intervallo su cui fare il plot
% Output: z = approssimazione della radice
%         res = f(z) residuo dell'equazione
%         it = numero di iterazioni effettuate


err=1+tol; % err per test d'arresto
k=0; % contatore iterazioni
fig=figure;
fplot(f,[a,b],'Linewidth',2)
grid on
hold on
xlabel('x')
ylabel('f(x)')
plot(x0,f(x0),'mo','Markerfacecolor','m')
while err > tol && k < kmax
    
    xnew=x0-f(x0)/df(x0);
    plot([xnew,xnew],[f(xnew),0],'k')
    plot(xnew,f(xnew),'mo','Markerfacecolor','m')
    t=@(x)df(x0)*(x-x0)+f(x0);
    plot([x0,xnew+0.5],[t(x0),t(xnew+0.5)],'k')
    err=abs(xnew-x0);
    x0=xnew;
    k=k+1;
    disp('premi un tasto per continuare')
    pause
end
z=xnew;  % copio l'ultima x(k+1) nella variabile di output
res=f(z); % valuto il residuo