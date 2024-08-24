 % SEGNALI E SISTEMI
% Laboratorio Matlab (24/05/2023)

% Initialization
% Clear the workspace
clear
% Close all the windows
close all
clc

% ***************
% * ESERCIZIO 1 *
% ***************
fprintf("CONVOLUZIONI A TEMPO DISCRETO\n")
%-------------------------------------------------------------------------
fprintf('\nES1 Punto 1\n\n');
%-------------------------------------------------------------------------
x=[1,4,2,4];    % ingresso
h=[2,4,1];      % risposta all'impulso
y=conv(x,h);    % calcolo dell'uscita tramite concoluzione

figure(1), set(1, 'WindowStyle', 'docked');
stem([0:length(x)+length(h)-2],y);  % rappresento l'uscita
title('y[n] a fronte di x=[1,4,2,4]; h=[2,4,1];   ');

fprintf("\npremere un tasto per continuare")
pause; 
clc
close all

% ***************
% * ESERCIZIO 2 *
% ***************
fprintf("EQUAZIONI ALLE DIFFERENZE\n")
%-------------------------------------------------------------------------
fprintf('\nES2 Punto 1\n\n');
%-------------------------------------------------------------------------
a = 0.9;
N = 100;
nn = 0:N;

% 1.a
delta = nn==0;
h = myfiltroIIRes1(a,delta);
figure(1), set(1, 'WindowStyle', 'docked');
stem(nn(1:25),h(1:25)), title('h[n]');

df = .001;
f = -1/2:df:1/2;
E = zeros(length(nn),length(f));
for k = 1:length(f)
    E(:,k) = exp(-1i*2*pi*f(k)*nn);
end
H = h*E;

figure(2), set(2, 'WindowStyle', 'docked'); 
plot(f,abs(H)), title('|H(f)|')

figure(3), set(3, 'WindowStyle', 'docked');
plot(f,angle(H),'r'), title('<H(f)')

fprintf("\npremere un tasto per continuare")
pause; 
clc
close all

%-------------------------------------------------------------------------
fprintf('\nES2 Punto 2 \n\n');
%-------------------------------------------------------------------------

fvec = [1/4 1/5 1/10 1/20]; % in [-1/2,1/2] or add fvec = mod(fvec+.5,1)+.5;
xi = zeros(length(fvec),length(nn));
z=1; 
for fi = fvec
    xi = sin(2*pi*fi*nn);
    yi = myfiltroIIRes1(a,xi);
    figure(z), set(z,'WindowStyle', 'docked');  stem(nn,yi), title(sprintf('f_i = %.2f',fi)), hold on
    H_fi = H(uint32((fi+0.5)/df)+1);
    plot(nn,abs(H_fi)*sin(2*pi*fi*nn+angle(H_fi)),'r--','Linewidth',1.5);
    z=z+1;
end

fprintf("\npremere un tasto per continuare")
pause; 
clc
close all

% ***************
% * ESERCIZIO 3 *
% ***************
fprintf("CONCATENZAZIONE SERIE\n")
%-------------------------------------------------------------------------
fprintf('\nES3 Punto 1 \n\n');
%-------------------------------------------------------------------------
% 2.c
N = 100;
nn = 0:N;

a = 0.5; b = 0.1;
h1 = a.^nn; h2 = b.^nn;

delta = nn==0;
h = myfiltroIIRes2(a,b,delta);
figure, stem(nn,h), title('h[n] (filtro II ordine)');

hconv = conv(h1,h2); hconv = hconv(1:N+1);
figure, stem(nn,hconv), title('h_{conv}[n] (convoluzione)');

fprintf('Energia dell''errore tra le due risposte all''impulso: %e\n',sum((hconv-h).^2));

x1 = cos(3*pi*nn/8);
x2 = cos(pi*nn);
y1 = myfiltroIIRes2(a,b,x1);
y2 = myfiltroIIRes2(a,b,x2);
y1conv = conv(x1,hconv); y1conv = y1conv(1:N+1);
y2conv = conv(x2,hconv); y2conv = y2conv(1:N+1);
figure, stem(nn,y1), title('y_1[n] (filtro II ordine)')
figure, stem(nn,y2), title('y_2[n] (filtro II ordine)')
figure, stem(nn,y1conv), title('y_{1;conv}[n] (convoluzione)')
figure, stem(nn,y2conv), title('y_{2;conv}[n] (convoluzione)')

% CLEAR
clear
close all


% ***************
% * ESERCIZIO 4 *
% ***************
fprintf("FILTRI PASSA-BASSO NUMERICI\n")
% Filtro FIR

N = 100;
nn = 0:N;

delta = nn==0;
b = [-0.0652 -0.0378 0.0599 0.4093 0.4824 0.4093...
    0.2354 0.0599 -0.0378 -0.0652];
h = myfiltroFIRes3(b,delta);
figure(1), stem(nn(1:25),h(1:25)), title('h[n]');

df = .001;
f = -1/2:df:1/2;
E = zeros(length(nn),length(f));
for k = 1:length(f)
    E(:,k) = exp(-1i*2*pi*f(k)*nn);
end
HFIR = h*E;
figure(2), plot(f,abs(HFIR)), title('|HFIR(f)|')
figure(3), plot(f,angle(HFIR),'r'), title('<HFIR(f)')

% Filtro IIR

b1 = [1 2 1];
a = [1 -0.377936 0.460234];
G = 0.270574;
h = myfiltroIIRes3(a,b1,G,delta);
figure(6), stem(nn(1:25),h(1:25)), title('h[n]');

HIIR = h*E;
figure(7), plot(f,abs(HIIR)), title('|HIIR(f)|')
figure(8), plot(f,angle(HIIR),'r'), title('<HIIR(f)')



