
% segnale x2(t) = abs(c9s(2 pi 1/4 t - pi/4) )
% con periodo T2= 2 e sviluppo di fourier fornito dal testo
% generare e disegnare x2
% approssimare con Marm {10,20,30}
% disegnare il segnale approssimato
% calcolare l'errore

close all;
drawnow;

% Punto 1

% Fundamental period
T2 = 2;

x2 = abs(cos(pi/2*t-pi/4));
figure(1), set(1, 'WindowStyle', 'docked')
plot(t,x2); title('x2'); axis([min(t) max(t) min(x2)-.25 max(x2)+.25]); grid on

% Punto 2

% Number of considered harmonics
NarmVet = [10 20 30 100];

% windowing of a single period, to compute X vector
x2SingPer = x2.*rect(t/T2);

% mean value - X0
X0 = 2/pi;
X0Calc = 1/T2*integrale(x2SingPer,dt);

% The signal is reconstructed in the rows, using X as given by the exact
% formula given in the pdf. Each row uses a different number of harmonics,
% found in NarmVet. The signal is initialized using the mean value.
x2Approx = zeros(length(NarmVet),length(t))+X0;

% The signal is reconstructed in the rows, using XCalc as numerically computed
% using the definition of X. Each row uses a different number of harmonics,
% found in NarmVet. The signal is initialized using the mean value.
x2ApproxCalc = zeros(length(NarmVet),length(t))+X0Calc;

for n = 1:length(NarmVet)
    Narm = NarmVet(n);

    Xpos = zeros(Narm,1);
    Xneg = zeros(Narm,1);
    XposCalc = zeros(Narm,1);
    XnegCalc = zeros(Narm,1);

    for k = 1:Narm
        % Xpos(k) => X(k)
        % Xneg(k) => X(-k) - substitute k with -k in the formula
        
        Xpos(k) = (-1)^(k+1)*2/(pi*(4*k^2-1))*exp(-1j*pi*k/2);
        %Xneg(k) = (-1)^(-k+1)*2/(pi*(4*(-k)^2-1))*exp(1j*pi*k/2);
        Xneg(k) = conj(Xpos(k)); % hermitian symmetry for real signals
        
        % ***************
        % * ESERCIZIO 3 *
        % ***************
        XnegCalc(k) = 1/T2*integrale(x2.*rect(t/T2).*exp(1j*2*pi*k/T2*t),dt);
        XposCalc(k) = 1/T2*integrale(x2.*rect(t/T2).*exp(-1j*2*pi*k/T2*t),dt);
        
        x2Approx(n,:) = x2Approx(n,:)+Xpos(k)*exp(1j*2*pi*k/T2*t)+Xneg(k)*exp(-1j*2*pi*k/T2*t);
        x2ApproxCalc(n,:) = x2ApproxCalc(n,:)+XposCalc(k)*exp(1j*2*pi*k/T2*t)+XnegCalc(k)*exp(-1j*2*pi*k/T2*t);
    end
    
    figure(2), set(2, 'WindowStyle', 'docked')
    subplot(length(NarmVet),2,n*2-1)
    stem(-Narm:Narm,real([flipud(Xneg); X0; Xpos]),'b'); hold on
    stem(-Narm:Narm,imag([flipud(Xneg); X0; Xpos]),'rx--'); axis tight
    title(sprintf('b secondo la formula data con %d armoniche',Narm)); grid on
    subplot(length(NarmVet),2,n*2)
    stem(-Narm:Narm,real([flipud(XnegCalc); X0; XposCalc]),'b'); hold on
    stem(-Narm:Narm,imag([flipud(XnegCalc); X0; XposCalc]),'rx--'); axis tight
    title(sprintf('b calcolato con l''integrale con %d armoniche',Narm)); grid on
    
    figure(2+n), set(2+n, 'WindowStyle', 'docked');
    plot(t,x2Approx(n,:)); title(sprintf('x2 ricostruito con X secondo la formula data con %d armoniche',Narm)); axis([min(t) max(t) min(x2)-.25 max(x2)+.25]); grid on
    figure(2+length(NarmVet)+n), set(2+length(NarmVet)+n, 'WindowStyle', 'docked');
    plot(t,x2ApproxCalc(n,:)); title(sprintf('x2 ricostruito con X calcolato con l''integrale con %d armoniche',Narm)); axis([min(t) max(t) min(x2)-.25 max(x2)+.25]); grid on
end


% Punto 3

% best approximation, that is with 30 harmonics
figure(2+2*n+1), set(2+2*n+1, 'WindowStyle', 'docked'), plot(t,x2,'b'); hold on, plot(t,x2Approx(end,:),'r--');
title('x2 vs. x2Approx'); axis([min(t) max(t) min(abs(x2Approx(end,:)))-.25 max(abs(x2Approx(end,:)))+.25]);

figure(2+2*n+2), set(2+2*n+2, 'WindowStyle', 'docked'), plot(t,x2-x2Approx(end,:));
title('Errore in x2Approx'); axis([min(t) max(t) min(x2-x2Approx(end,:))-.1 max(x2-x2Approx(end,:))+.1]);
fprintf('Potenza dell''errore per la ricostruzione di x2 con %d armoniche: %.3e\n',NarmVet(end),1/T2*integrale(((x2-x2Approx(end,:)).*rect(t/T2)).^2,dt));
pause;