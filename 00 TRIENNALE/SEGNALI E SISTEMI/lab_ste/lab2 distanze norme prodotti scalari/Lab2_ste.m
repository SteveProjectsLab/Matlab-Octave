% SEGNALI E SISTEMI
% Laboratorio Matlab del 22/03/2023

clear all
close all
clc

% Temporal axis
dt = 0.01;
t = -10:dt:10;

% Color list for plots
colors = {'b' 'g' 'r' 'c' 'm' 'y' 'k'...
    'b--' 'g--' 'r--' 'c--' 'm--' 'y--' 'k--'...
    'b:' 'g:' 'r:' 'c:' 'm:' 'y:' 'k:'};

%-------------------------------------------------------------------------
% ***************
% * ESERCIZIO 1 *
% ***************
%-------------------------------------------------------------------------
fprintf('ES1: integrale numerico:\nverifica del corretto funzionamento della funzione integrale\n\n')
% (i) Si implementi la funzione integrale(x,dt) che accetti in ingresso il vettore x con i valori del segnale
% da integrare e la distanza temporale dt tra i suoi elementi (cio`e il passo dell’asse temporale t);
% (ii) Se ne verifichi la funzionalit`a calcolando l’area e l’energia dei segnali rect(t), tri(t) e la potenza del
% segnale 
%-------------------------------------------------------------------------

fprintf('L''area del rect e'' : %.2f\n',integrale(rect(t),dt));
fprintf('L''area del tri e'' : %.2f\n',integrale(tri(t),dt));
fprintf('L''energia del rect e'' : %.2f\n',integrale(rect(t).^2,dt));
fprintf('L''energia del tri e'' : %.2f\n',integrale(tri(t).^2,dt));

T = 3; % fundamental period
x = sin(2*pi/T*t(t>=0&t<T)); % a period of sin (this x is shorter than t!!!)
% x = sin(2*pi/T*t).*rect(t/T); % windowing method
fprintf('La potenza del sin e'' : %.2f\n',1/T*integrale(x.^2,dt));
fprintf('\npremi un tasto per continuare\n')
pause;
clc

%-------------------------------------------------------------------------
% ***************
% * ESERCIZIO 2 *
% ***************
%-------------------------------------------------------------------------
fprintf('ES2 Punto 1 calcolo di distanze, norme, prodotti scalari, Schwarz\n\n');
% verificarle usando i segnali (meglio costruirsi le funzioni myNorm, myScalarProduct e myDistance):
% (i) x1(t) = 3 · rect (t) ; y1(t) = tri (t);
%-------------------------------------------------------------------------


x1 = 3*rect(t); y1 = tri(t);

nx1 = myNorm(x1,dt); ny1 = myNorm(y1,dt);
psx1y1 = myScalarProduct(x1,y1,dt); psy1x1 = myScalarProduct(y1,x1,dt);
dx1y1 = myDistance(x1,y1,dt);

fprintf('La norma di x1 vale: %.3f\nLa norma di y1 vale: %.3f\n',nx1,ny1);
fprintf('Il prodotto scalare di x1 con y1 vale: %.3f+%.3fi\n',real(psx1y1),imag(psx1y1));
fprintf('Il prodotto scalare di y1 con x1 vale: %.3f+%.3fi\n',real(psy1x1),imag(psx1y1));
fprintf('La distanza tra x1 e y1 vale: %.3f\n',dx1y1);
fprintf('d^2 = n1^2+n2^2-2Re{ps}: %.3f=%.3f+%.3f-%.3f=%.3f\n',...
    dx1y1^2,nx1^2,ny1^2,2*real(psx1y1),nx1^2+ny1^2-2*real(psx1y1));
fprintf('Dis. Schwarz, |ps|<=n1*n2: %.3f<=%.3f*%.3f=%.3f\n',...
    abs(psx1y1),nx1,ny1,nx1*ny1);

fprintf('\npremi un tasto per continuare\n')
pause;
clc

%-------------------------------------------------------------------------
fprintf('\nES2 Punto 2\n\n');
% (ii) x2(t) = tri (t) ; y2(t) = tri (t − 1);
%-------------------------------------------------------------------------

x2 = tri(t); y2 = tri(t-1);

nx2 = myNorm(x2,dt); ny2 = myNorm(y2,dt);
psx2y2 = myScalarProduct(x2,y2,dt); psy2x2 = myScalarProduct(y2,x2,dt);
dx2y2 = myDistance(x2,y2,dt);

fprintf('La norma di x2 vale: %.3f\nLa norma di y2 vale: %.3f\n',nx2,ny2);
fprintf('Il prodotto scalare di x2 con y2 vale: %.3f%+.3fi\n',real(psx2y2),imag(psx2y2));
fprintf('Il prodotto scalare di y2 con x2 vale: %.3f%+.3fi\n',real(psy2x2),imag(psx2y2));
fprintf('La distanza tra x2 e y2 vale: %.3f\n',dx2y2);
fprintf('d^2 = n1^2+n2^2-2Re{ps}: %.3f=%.3f+%.3f-%.3f=%.3f\n',...
    dx2y2^2,nx2^2,ny2^2,2*real(psx2y2),nx2^2+ny2^2-2*real(psx2y2));
fprintf('Dis. Schwarz, |ps|<=n1*n2: %.3f<=%.3f*%.3f=%.3f\n',...
    abs(psx2y2),nx2,ny2,nx2*ny2);

fprintf('\npremi un tasto per continuare\n')
pause;
clc

%-------------------------------------------------------------------------
fprintf('\nES2 Punto 3\n\n');
% (iii) x3(t) = 2 · e−|t|; y3(t) = j · tri (t).
%-------------------------------------------------------------------------

x3 = 2*exp(-abs(t)); y3 = 1j*tri(t);

nx3 = myNorm(x3,dt); ny3 = myNorm(y3,dt);
psx3y3 = myScalarProduct(x3,y3,dt); psy3x3 = myScalarProduct(y3,x3,dt);
dx3y3 = myDistance(x3,y3,dt);

fprintf('La norma di x3 vale: %.3f\nLa norma di y3 vale: %.3f\n',nx3,ny3);
fprintf('Il prodotto scalare di x3 con y3 vale: %.3f%+.3fi\n',real(psx3y3),imag(psx3y3));
fprintf('Il prodotto scalare di y3 con x3 vale: %.3f%+.3fi\n',real(psy3x3),imag(psy3x3));
fprintf('La distanza tra x3 e y3 vale: %.3f\n',dx3y3);
fprintf('d^2 = n1^2+n2^2-2Re{ps}: %.3f=%.3f+%.3f-%.3f=%.3f\n',...
    dx3y3^2,nx3^2,ny3^2,2*real(psx3y3),nx3^2+ny3^2-2*real(psx3y3));
fprintf('Dis. Schwarz, |ps|<=n1*n2: %.3f<=%.3f*%.3f=%.3f\n',...
    abs(psx3y3),nx3,ny3,nx3*ny3);

fprintf('\npremi un tasto per continuare\n')
pause;
clc
%-------------------------------------------------------------------------
% % *********************************
% % * ESERCIZIO 2 - versione inline *
% % *********************************
% 
% 
% % Funzioni
% funz = {inline('3*rect(t)') inline('tri(t)');...
%      inline('tri(t)') inline('tri(t-1)');...
%      inline('2*exp(-abs(t))') inline('1j*tri(t)')};
% 
% for punto = 1:size(funz,1)
% 
%     x = funz{punto,1}(t); y = funz{punto,2}(t);
% 
%     n1 = myNorm(x,dt); n2 = myNorm(y,dt);
%     ps1 = myScalarProduct(x,y,dt); ps2 = myScalarProduct(y,x,dt);
%     d = myDistance(x,y,dt);
% 
%     fprintf('\n*** Punto %d ***\n\n',punto);
%     fprintf('La norma di x vale: %.3f\nLa norma di y vale: %.3f\n',n1,n2);
%     fprintf('Il prodotto scalare di x con y vale: %.3f%+.3fi\n',real(ps1),imag(ps1));
%     fprintf('Il prodotto scalare di y con x vale: %.3f%+.3fi\n',real(ps2),imag(ps2));
%     fprintf('La distanza tra x e y vale: %.3f\n',d);
%     fprintf('d^2 = n1^2+n2^2-2Re{ps}: %.3f=%.3f+%.3f-%.3f=%.3f\n',...
%         d^2,n1^2,n2^2,2*real(ps1),n1^2+n2^2-2*real(ps1));
%     fprintf('Dis. Schwarz, |ps1|<=n1*n2: %.3f<=%.3f*%.3f=%.3f\n',...
%         abs(ps1),n1,n2,n1*n2);
% end


%-------------------------------------------------------------------------
% ***************
% * ESERCIZIO 3 *
% ***************
%-------------------------------------------------------------------------
% In questo esercizio si calcola l’approssimazione costante a tratti di un dato segnale che sia ottima in norma
% quadratica (ovvero che minimizzi l’energia dell’errore di approssimazione). L’approssimazione viene calcolata
% proiettando il segnale originale in uno spazio vettoriale generato dai segnali costituenti una base ortonormale.
% Definiamo x(t) = 10 sin(t) · (1 +sqrt|t|).
% (i) Si consideri la base di funzioni Φ = {φk(t)}, k = 1, . . . , 20, dove φk(t) = rect(t − k + 21/2). Si generi
% una matrice B di 20 righe che contenga nella k-esima riga il segnale φk(t);
% (ii) Si verifichi che Φ `e ortonormale, calcolando una matrice G con i prodotti scalari incrociati tra i vettori
% della base, G = {⟨φk, φh⟩}, e verificando che ⟨φk, φh⟩ = δhk, cio`e G = I;
% (iii) Si calcoli la proiezione di x su Φ, calcolando αk = ⟨x, φk⟩ e si costruisca infine il segnale Appr x che
% rappresenta lsapprossimazione ˆx(t) di x(t), ottenuta come ˆx =sumk αk · φk, lo si disegni e si calcoli
% l energia dell’errore di approssimazione.

% % Segnale da approssimare, punti 3.(i)-(iii) e 4.(i)-(ii)
x = 10*sin(t).*(1+sqrt(abs(t)));

% Punto 4.(iii)
%x = 10*sin(2*pi*t).*(1+sqrt(abs(t)));


% Punto 1
% base di rect
fprintf('\nES3 Punto 1\n\n');
fprintf("creazione di una base di rect..\n")
title('Base di rect')

B1 = zeros(20,length(t));
for k = 1:20
    B1(k,:) = rect(t-k+21/2);
    figure(1),set(1, 'WindowStyle', 'docked'), plot(t,B1(k,:),colors{k}), hold on, grid on
end



fprintf('\npremi un tasto per continuare\n')
pause;
close all
clc

%-------------------------------------------------------------------------

fprintf('\nES3 Punto 2\n\n');
fprintf("verifico che sia ortonormale;\n per farlo calcolo i prodotti scalarti incrociati\n\n")
G1 = zeros(20,20);
for k = 1:20
    for h = 1:20
        G1(k,h) = integrale(B1(k,:).*conj(B1(h,:)),dt);
    end
end
fprintf('G1:\n');
disp(G1)

% se G=I allora è ortonormale
fprintf('\npremi un tasto per continuare\n')
pause;
clc

%-------------------------------------------------------------------------
fprintf('\nES3 Punto 3\n\n');
fprintf("calcolo la proiezione del segnale sulla base\\n")
%-------------------------------------------------------------------------
% costrisco il segnale che rappresenta l'approssimazione

Appr_x = zeros(size(t));
alpha1 = zeros(20,1);
for k = 1:20
    alpha1(k) = integrale(x.*conj(B1(k,:)),dt);
    Appr_x = Appr_x + alpha1(k)*B1(k,:);
end
figure(2),set(2, 'WindowStyle', 'docked'), plot(t,x,'r','LineWidth',2), hold on
plot(t,Appr_x), title('$$x\ \mbox{e}\ \hat{x}$$','Interpreter','latex');
fprintf('\nEnergia dell''errore di approssimazione per la base di rect: %2.3f\n',...
    integrale((abs(x-Appr_x)).^2,dt)), grid on;

fprintf('\npremi un tasto per continuare\n')
pause;
clc 
close all

%-------------------------------------------------------------------------
% ***************
% * ESERCIZIO 4 *
% ***************
%-------------------------------------------------------------------------
% Si consideri la base non ortogonale Φ2 = {ϕk(t)}, k = 1, . . . , 21, dove ϕk(t) = tri(t−k+11). Si costruisca
% la matrice B2 in modo analogo all’esercizio 3.(i) e la matrice G2 in modo analogo all’esercizio 3.(ii),
% verificando che G2 in questo caso non `e diagonale (nello specifico essa `e tridiagonale);
% (ii) Si ortogonalizzi la base Φ2, ottenendo Φ3 = {ψk(t)}, utilizzando il processo di ortogonalizzazione di
% Gram-Schmidt:
%     formule
% Si calcoli quindi la proiezione di x su Φ3 e si ripetano i passi dei punti (i)-(iii);
% (iii) Provare ad eseguire il programma che implementa lsesercizio 3 e 4 con x2(t) = 10 sin(2πt) · (1 +sqrt|t|)
% e provare a giustificare l’accaduto.
%-------------------------------------------------------------------------
fprintf('\nES4 Punto 1\n\n');
fprintf("data una base NON ortogonale, verificarlo\n\n")
%-------------------------------------------------------------------------
B2 = zeros(21,length(t));
for k = 1:21
    B2(k,:) = tri(t-k+11);
    figure(3),set(3, 'WindowStyle', 'docked'), plot(t,B2(k,:),colors{k}), hold on, grid on
end
title('Base di tri')

G2 = zeros(21,21);
for k = 1:21
    for h = 1:21
        G2(k,h) = integrale(B2(k,:).*conj(B2(h,:)),dt);
    end
end
fprintf('G2:\n');
disp(G2)



fprintf('\npremi un tasto per continuare\n')
pause;
clc
close all

%-------------------------------------------------------------------------
fprintf('\nES4 Punto 2\n\n');
fprintf("Ortogonalizza la base con Gram-Schmidt\n\n")
%-------------------------------------------------------------------------

B2ort = zeros(21,length(t));
B2ort(1,:) = B2(1,:)/sqrt(integrale((abs(B2(1,:))).^2,dt));
figure(4),set(4, 'WindowStyle', 'docked'), plot(t,B2ort(1,:),colors{1}), hold on
for k = 2:21
    v = B2(k,:);
    for r = 1:k-1
        v = v-integrale(v.*conj(B2ort(r,:)),dt).*B2ort(r,:);
    end
    B2ort(k,:) = v/sqrt(integrale((abs(v)).^2,dt));
    figure(4),set(4, 'WindowStyle', 'docked'), plot(t,B2ort(k,:),colors{k}), hold on
end
title('Base di tri ortogonalizzata')

  
G2ort = zeros(21,21);
for k = 1:21
    for h = 1:21
        G2ort(k,h) = integrale(B2ort(k,:).*conj(B2ort(h,:)),dt);
    end
end
fprintf('G2ort:\n');
disp(G2ort)

Appr_x3 = zeros(size(t));
alpha3 = zeros(21,1);
for k = 1:21
    alpha3(k) = integrale(x.*conj(B2ort(k,:)),dt);
    Appr_x3 = Appr_x3 + alpha3(k)*B2ort(k,:);
end
figure(5),set(5, 'WindowStyle', 'docked'), plot(t,x,'r','LineWidth',2), hold on, grid on
plot(t,Appr_x3), title('$$x\ \mbox{e}\ \hat{x}_3$$','Interpreter','latex');
fprintf('\nEnergia dell''errore di approssimazione per la base di tri ortogonalizzata: %2.3f\n',...
    integrale((abs(x-Appr_x3)).^2,dt))

fprintf('\npremi un tasto per continuare\n')
pause;
clc
close all
clear all
%-------------------------------------------------------------------------