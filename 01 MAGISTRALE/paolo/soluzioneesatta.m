% dati
m= 15 %kg
k= 17000 %N/m
v=0.05 %fattore smorzamento
%p1= 8*(pi*t/0.6) %forzante esterna per 0<=t<=0.6
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
F= -0.0028

% definizione dell'intervallo
t1 = linspace(0, 0.6, 1000); % Intervallo da 0 a 0.6 con 1000 punti
t2 = linspace(0.6, 2, 1000); % intervallo da 0.6 a 2 con 1000 punti

% definizione della funzione
V1 =exp(-v*w0*t1).*(A*cos(wd*t1)+B*sin(wd*t1))+C*sin(w*t1)+D*cos(w*t1);
V2 =exp(-v*w0*t2).*(E*cos(wd*t2)+F*sin(wd*t2));

% Unione delle due parti della funzione V(t)
V = [V1, V2];

% creazione del grafico
figure; %crea una nuova finestra per il grafico
plot([t1,t2], V, 'b-', 'LineWidth', 1.5); %crea il grafico con una linea blu
title('Grafico della funzione V(t)'); %titolo del grafico
xlabel('t'); %etichetta dell'asse t
ylabel('v(t)'); %etichetta dell'asse V(t)
grid on; %mostra la griglia
