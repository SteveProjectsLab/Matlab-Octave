clear all
close all

t = linspace(0, 2, 100000); 

% dati
m= 15 %kg
k= 17000 %N/m
v=0.05 %fattore smorzamento
p1= 8*(pi*t/0.6) %forzante esterna per 0<=t<=0.6
p2= 0 %forzante esterna per t>0.6
w0= sqrt(k/m) %pulsazione propria
wd= w0*sqrt(1-v^2) %pulsazione propria sistema smorzato
w= pi/0.6 %pulsazione forzante
z= 2*v*w0*m %smorzamento

% definisco le costanti
C= ((8*(m*w^2-k))/(-m^2*w^4+2*k*m*w^2-z^2*w^2-k^2))
D= (z*C*w)/(m*w^2-k)
A= -D
B= (A*v*w0-C*w)/(wd)
E= -0.000018016
G= -0.0028

% Definiamo la forzante a tratti 


p = zeros(1, length(t)); % Inizializza l'array p
v = zeros(1, length(t)); % Inizializza l'array v
F = zeros(1, length(t)); % Inizializza l'array F
x_e= zeros(1, length(t)); 
v_e= zeros(1, length(t)); 

% Trova l'indice per t = 0.6
index_06 = find(t >= 0.6, 1)
%%
for i = 1:length(t)
    if t(i) <= 0.6
        
        
        F(i) = 8*sin(pi*t(i)/0.6); 
        x_e(i) = exp.*(-v*w0*t(i).*(A*cos(wd*t(i))+B*sin(wd*t(i)))+C*sin(w*t(i))+D*cos(w*t(i));
        v_e(i) = -v*w0*exp(-v*w0*t(i))*(A*cos(wd*t(i))+B*sin(wd*t(i)))+exp(-v*w0*t(i))*(-A*wd*sin(wd*t(i))+B*wd*cos(wd*t(i)))+C*w*cos(w*t(i))-D*w*sin(w*t(i));
    else t(i) > 0.6 
        
       
        F(i) = 0;
        u0 = x_e(35000);
        v0 = v_e(35000);
        
        AA = -8000 / (0.3 * K);
        BB = (8000 - c * AA) / K;
        DD = u0 - BB;
        EE = (-AA + nu * omega1 * DD + v0) / omegad;
        
        
        x_e(i) = exp(-v*w0*t2).*(E*cos(wd*t2)+G*sin(wd*t2));
   
    end
end

% Traccia la soluzione esatta della posizione x(t)
figure;
plot(t, x_e, 'b', 'LineWidth', 2);
title('Soluzione Esatta della Posizione');
xlabel('Tempo (s)');
ylabel('Posizione (m)');
grid on;


    %Diff finite centrate
for i = 1:length(t)-1
     delta = t(2) - t(1);
    k=m/delta^2+c/(2*delta);
    a=m/delta^2-c/(2*delta);
    b=K-2*m/(delta)^2;
    v02=8000/m;

    if i==1
        p(i)=F(i)-b*v(i);
        v(i+1)=p(i)/k;
    else p(i)=F(i)-a*v(i-1)-b*v(i);
            v(i+1)=p(i)/k;
    end
end

figure
subplot(3,2,[1 2])
plot(t, x_e, 'b', 'LineWidth', 2);
title('Soluzione Esatta della Posizione');
xlabel('Tempo (s)');
ylabel('Posizione (m)');
grid on
hold on;

subplot(3,2,3)
plot(t,v,'Color', [0.6, 1, 0], 'LineWidth', 2);
hold on
plot(t, x_e, '--b', 'LineWidth', 1); 
title('Differenze finite')
xlabel('Tempo (s)');
ylabel('Posizione (m)');
grid on;
legend('Numerica','Esatta')


p = zeros(1, length(t)); % Inizializza l'array p
v = zeros(1, length(t)); % Inizializza l'array v
x = zeros(1, length(t)); % Inizializza l'array 
a = zeros(1, length(t)); % Inizializza l'array 

% Metodo di accelerazione lineare di Newmark
gamma = 1/2;
beta = 1/6;
for i = 1:length(t)-1
   delta = t(i+1) - t(i);
    v02=(8*(pi*t/0.6))/m;
    a1=m/(beta*delta^2)+gamma*c/(beta*delta);
    a2=m/(beta*delta)+(-1+gamma/beta)*c;
    a3=m*(1/(2*beta)-1)+delta*c*(-1+gamma/(2*beta));
    k=K+a1;
    if i==1
        p(i+1)=F(i+1)+a3*v02;
        x(i+1)=p(i+1)/k;
        v(i+1)=gamma/(beta*delta)*(x(i))+delta*(1-gamma/(2*beta))*v02;
        a(i+1)=1/(beta*delta^2)*(x(i))-(1/(2*beta)-1)*v02;
    else p(i+1)=F(i+1)+a1*x(i)+a2*v(i)+a3*a(i);
        x(i+1)=p(i+1)/k;
        v(i+1)=gamma/(beta*delta)*(x(i+1)-x(i))+(1-gamma/beta)*v(i)+delta*(1-gamma/(2*beta))*a(i);
        a(i+1)=1/(beta*delta^2)*(x(i+1)-x(i))-1/(beta*delta)*v(i)-(1/(2*beta)-1)*a(i);
    end
end


% Grafico della posizione calcolata con il metodo di accelerazione lineare di Newmark
subplot(3, 2, 5);
plot(t, x, 'r', 'LineWidth', 2);
hold on
plot(t, x_e, '--b', 'LineWidth', 1); 
title('Posizione con Accelerazione Lineare di Newmark');
xlabel('Tempo (s)');
ylabel('Posizione (m)');
grid on;
legend('Numerica','Esatta')

% Metodo di accelerazione media costante di Newmark
gamma = 1/2;
beta = 1/4;

for i = 1:length(t)-1
   delta = t(i+1) - t(i);
    v02=8000/m;
    a1=m/(beta*delta^2)+gamma*c/(beta*delta);
    a2=m/(beta*delta)+(-1+gamma/beta)*c;
    a3=m*(1/(2*beta)-1)+delta*c*(-1+gamma/(2*beta));
    k=K+a1;
    if i==1
        p(i+1)=F(i+1)+a3*v02;
        x(i+1)=p(i+1)/k;
        v(i+1)=gamma/(beta*delta)*(x(i+1))+delta*(1-gamma/(2*beta))*v02;
        a(i+1)=1/(beta*delta^2)*(x(i+1))-(1/(2*beta)-1)*v02;
    else p(i+1)=F(i+1)+a1*x(i)+a2*v(i)+a3*a(i);
        x(i+1)=p(i+1)/k;
        v(i+1)=gamma/(beta*delta)*(x(i+1)-x(i))+(1-gamma/beta)*v(i)+delta*(1-gamma/(2*beta))*a(i);
        a(i+1)=1/(beta*delta^2)*(x(i+1)-x(i))-1/(beta*delta)*v(i)-(1/(2*beta)-1)*a(i);
    end
end

% Grafico della posizione calcolata con il metodo di accelerazione media costante di Newmark
subplot(3, 2, 6);
plot(t, x, 'g', 'LineWidth', 2);
hold on;
grid on
plot(t, x_e, '--b', 'LineWidth', 1); 
title('Posizione con Accelerazione Media Costante di Newmark');
xlabel('Tempo (s)');
ylabel('Posizione (m)');
legend('Numerica','Esatta')



    %Interpolazione lineare 
    delta=0.01;
     a11=exp(-nu*omega1*delta)*(nu*(omega1/omegad)*sin(omegad*delta)+cos(omegad*delta));
     a22=exp(-nu*omega1*delta)*(-nu*(omega1/omegad)*sin(omegad*delta)+cos(omegad*delta));
     a12=exp(-nu*omega1*delta)*((1/omegad)*sin(omegad*delta));
     a21=-exp(-nu*omega1*delta)*(omega1/sqrt(1-nu^2)*sin(omegad*delta));
     b11=-exp(-nu*omega1*delta)*((nu/(omega1*omegad)+(2*nu^2-1)/(omega1^2*omegad*delta))...
         *sin(omegad*delta)+(1/(omega1^2)+2*nu/(omega1^3*delta))*cos(omegad*delta))+2*nu/(omega1^3*delta);
     b12=exp(-nu*omega1*delta)*((2*nu^2-1)/(omega1^2*omegad*delta)*...
         sin(omegad*delta)+2*nu/(omega1^3*delta)*cos(omegad*delta))+1/(omega1^2)-2*nu/(omega1^3*delta);
     b21=exp(-nu*omega1*delta)*((1/omegad+nu/(omega1*omegad*delta))*...
         sin(omegad*delta)+1/(omega1^2*delta)*cos(omegad*delta))-1/(omega1^2*delta);
     b22=-exp(-nu*omega1*delta)*(nu/(omega1*omegad*delta)*sin(omegad*delta)+1/(omega1^2*delta)*cos(omegad*delta))+1/(omega1^2*delta);

     %%Costanti prof
     % a11 = exp(-nu*omega1*delta)* (nu/sqrt(1 - nu^2)* sin(omegad*delta) + cos(omegad *delta))
     % a12= exp(-nu*omega1*delta)* (1/omegad*sin(omegad*delta))
     % b11 = 1/K* (2*nu/(omega1*delta)+...
     %     exp(-nu*omega1*delta)*...
     %     (((1-2*nu^2)/(omegad*delta)-nu/sqrt(1-nu^2))*sin(omegad*delta)-...
     %     (1+2*nu/(omega1*delta))*cos(omegad*delta)))
     % b12 = 1/K *(1 - (2*nu)/(omega1*delta) + exp(-nu*omega1*delta)* ...
     %     (((2*nu^2 - 1)/(omegad*delta)* sin(omegad*delta) + (2*nu)/(omega1*delta)*cos(omegad*delta))))
     % a21=-exp(-nu*omega1*delta)*(omega1/sqrt(1-nu^2)*sin(omegad*delta))
     % a22=exp(-nu*omega1*delta)*(cos(omegad*delta)-nu/sqrt(1-nu^2)*sin(omegad*delta))
     % b21=1/K*(-1/delta+exp(-nu*omega1*delta)*...
     %     ((omega1/sqrt(1-nu^2)+nu/(delta*sqrt(1-nu^2)))*sin(omegad*delta)+1/delta*cos(omegad*delta)))
     % b22=1/(K*delta)*(1-exp(-nu*omega1*delta)*(nu/sqrt(1-nu^2)*sin(omegad*delta)+cos(omegad*delta)))
     x = zeros(1, length(t)); % Inizializza l'array x
     v = zeros(1, length(t)); % Inizializza l'array v
     f=zeros(1, length(t));
     x(1)=0;v(1)=0;
     for i = 1:length(t)-1
     f(i)=F(i)/m;
     x(i+1)=a11*x(i)+a12*v(i)+b11*f(i)+b12*f(i+1);
     v(i+1)=a21*x(i)+a22*v(i)+b21*f(i)+b22*f(i+1);
     end
     % 
     
% Grafico della posizione calcolata con il metodo dell'interpolazione
% lineare
subplot(3, 2, 4);
plot(t,x,'Color', [1, 0.5, 0], 'LineWidth', 2);
hold on;
grid on
plot(t, x_e, '--b', 'LineWidth', 1); 
title('Posizione con interpolazione lineare della forzante');
xlabel('Tempo (s)');
ylabel('Posizione (m)');
legend('Numerica','Esatta')