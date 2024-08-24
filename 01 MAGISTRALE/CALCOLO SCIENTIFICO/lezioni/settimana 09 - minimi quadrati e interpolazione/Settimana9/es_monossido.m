% dati problema monossido 
t =(0:24)';
y =[164.05; 73.72; 23.39; 17.11; 20.31; 29.37; 74.74; 117.02;
298.04; 348.13; 294.75; 253.78; 250.48; 239.48; 236.52; 245.04;
286.74; 304.78; 288.76; 247.11; 216.73; 185.78; 171.19; 171.73; 
164.05];

% costruisco l'appx nel senso dei minimi quadrati con una funzione
% polinomiale di grado 8

a=polyfit(t,y,8); % trovo il vettore dei coefficienti

% valuto il polinomio in un insieme piuà fitto di punti
t1=linspace(0,24,500)';
p1=polyval(a,t1); 

% disegno
figure(1); clf
plot(t,y,'o') % dati
hold on
plot(t1,p1) % polinomio calcolato con minimi quadrati
grid on
xlabel('t')
ylabel('valori di NO')

% costruisco l'appx nel senso dei mini quad, con sin e cos
n=length(t); % numero di dati
w=2*pi/24;
X=[ones(n,1), sin(w*t), cos(w*t), sin(2*w*t), cos(2*w*t),...
    sin(3*w*t),cos(3*w*t),sin(4*w*t),cos(4*w*t)];
% risolvo il sistema X a =y nel senso dei min quad

% cioe' calcolo la fatt QR di X
[Qtilde,Rtilde]=qr(X,"econ");
% risolvo il sistema Rtilde a=Qtilde'*y
a=sost_indietro(Rtilde,Qtilde'*y);
% uso sempre il vettore dei punti t1
g2=a(1)+a(2)*sin(w*t1)+a(3)*cos(w*t1)+...
    a(4)*sin(2*w*t1)+a(5)*cos(2*w*t1)+...
    a(6)*sin(3*w*t1)+a(7)*cos(3*w*t1)+...
    a(8)*sin(4*w*t1)+a(9)*cos(4*w*t1);

% disegno
figure(2); clf
plot(t,y,'o') % dati
hold on
plot(t1,g2) % funzione sin-cos calcolato con minimi quadrati
grid on
xlabel('t')
ylabel('valori di NO')











