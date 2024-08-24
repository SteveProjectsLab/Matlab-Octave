% problema boa
% definisco i dati
R=0.055; % [m] raggio della boa
rhob=0.6; % [kg/m^3] densita' della boa
f=@(x)x.^3-3*x.^2*R+4*R^3*rhob; % function handle della funzione di cui
% calcolare la radice

% localizzo la/le radice
figure(1); clf
fplot(f,[-0.1,0.2],'Linewidth',2)
hold on
plot([0,2*R],[0,0],'Linewidth',2)
grid on
xlabel('x')
ylabel('f(x)')

scelta=menu('Scegli il metodo',...
            'bisezione',...
            'Newton',...
            'secanti');

if scelta==1
  % definisco i dati per bisezione
  a=0; b=2*R; % estremi dell'intervallo iniziale per bisezione
  tol=1e-8; % tolleranza per il test d'arresto
  kmax=100; % numero massimo di iterazioni
  [zero,res,k]=bisezione(f,a,b,tol,kmax)

  % rappresento sul grafico la soluzione calcolata
  figure(1)
  plot(zero,res,'x')

  kmin_teorico=ceil(log2((b-a)/tol)-1)

elseif scelta==2
  % definisco i dati per Newton
  df=@(x)3*x.^2-6*x*R; % derivata di f
  x0=0; % punto iniziale 
  tol=1e-8; % tolleranza per il test d'arresto
  kmax=100; % numero massimo di iterazioni
  [zero,res,k]=newton(f,df,x0,tol,kmax)
  % rappresento sul grafico la soluzione calcolata
  figure(1);
  plot(zero, res, 'ro','Markerfacecolor','r')

elseif scelta==3
  % definisco i dati per secanti
  x0=0;
  x1=0.05;
  tol=1e-8;
  kmax=100;
  [zero,res,k]=secanti(f,x0,x1,tol,kmax)
  % rappresento sul grafico la soluzione calcolata
  figure(1);
  plot(zero, res, 'ro','Markerfacecolor','r')
end
