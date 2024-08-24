% SEGNALI E SISTEMI
% Laboratorio Matlab del 17/05/2023

% Initialization
% Clear the workspace
clear
% Close all the windows
close all

% Time and frequency axes
dt = 0.01;
t = -10:dt:10;
df = dt;
f = -15:df:15;
%-------------------------------------------------------------------------
% *******************
% * ESERCIZIO 1 e 2 *
% *******************
%-------------------------------------------------------------------------
x = 8*sinc(t/2); % esercizio 1
% x = 4*exp(-10*t.^2); % esercizio 2a
% x = rect(t/sqrt(2)); % esercizio 2b

figure
plot(t,x), title('x')

X = T_Fourier(x,t,f);
figure
plot(f,abs(X)), title('X')

origine = ceil(length(t)/2);
for n = 10:10:50
    Tc = n*dt;
    tsample = mod(origine,n):n:length(t);
    xc = zeros(1,length(t));
    xc(tsample) = x(tsample);
    figure
    stem(t,xc), title(sprintf('Segnale campionato xc, con Tc=%.2f',Tc))
    
    % Fourier Transform
    Xc = T_Fourier(xc,t,f)/dt;
    figure
    plot(f,abs(Xc)), title(sprintf('Spettro segnale campionato Xc, con Tc=%.2f',Tc))
    
    % Ideal interpolation
    xr_i = zeros(1,length(t));
    for k = 1:length(tsample)
        xr_i = xr_i + xc(tsample(k))*sinc((t-t(tsample(k)))/Tc);
    end
    figure
    plot(t,xr_i,t,x), title(sprintf('Segnale ricostruito idealmente xr_i, con Tc=%.2f',Tc))
    fprintf('Energia dell''errore di ricostruzione con interpolatore ideale e Tc=%.3f: %.3f\n',...
        Tc, integrale(abs(x-xr_i).^2,dt))
    
    % ZOH interpolation
    x_ZOH = zeros(1,length(t));
    for k = 1:length(tsample)-1
        x_ZOH(tsample(k):tsample(k+1)-1) = xc(tsample(k));
    end
    x_ZOH(tsample(end):end) = xc(tsample(end));
    figure
    plot(t,x_ZOH,t,x), title(sprintf('Segnale ricostruito mediante interpolazione ZOH xZOH, con Tc=%.2f',Tc))
    fprintf('Energia dell''errore di ricostruzione mediante interpolazione ZOH e Tc=%.3f: %.3f\n',...
        Tc, integrale(abs(x-x_ZOH).^2,dt))
end
pause;
close all;
%-------------------------------------------------------------------------
% ***************
% * ESERCIZIO 3 *
% ***************
%-------------------------------------------------------------------------
%-------------------------------------------------------------------------

x = 3+12.5/pi*sin(2*pi*1/4*t);
xq = myQuant(x,4);
figure, plot(t,xq,'Linewidth',2)
hold on, plot(t,x,'r--'), title('TEST')
pause;
close;

%-------------------------------------------------------------------------
% ***************
% * ESERCIZIO 2 *
% ***************
%-------------------------------------------------------------------------

x = 1/2*t.^3+5*t.^2+20-2*(t+10).^2;

for bits = [2 4 8 16]
    xq = myQuant(x,bits);
    figure, plot(t,xq,'Linewidth',2)
    hold on, plot(t,x,'r--'), title(sprintf('%d bits',bits))
    
    errq = x-xq;
    fprintf('Energia dell''errore di quantizzazione con %d bits: %.4f\n',...
        bits,integrale(errq.^2,dt)/20);
    % Uso histc
    binEdges = linspace(-(max(x)-min(x))/2^(bits+1),(max(x)-min(x))/2^(bits+1),21);
    dx = binEdges(2)-binEdges(1);
    h_e = histc(errq,binEdges);
    pdf_e = h_e(1:end-1)/(dx*length(x));
    figure, plot(binEdges(1:end-1)+dx/2,pdf_e), title(sprintf('pfd caso %d bits',bits));
    axis([binEdges(1) binEdges(end) 0 max(pdf_e)])
end

% All'aumentare del numero di bits la pdf di errq diventa uniforme

figure;
plot(t,errq); title('Errore di quantizzazione');
fprintf('Energia dell''errore di quantizzazione con molti bits: %.3e\n',...
    integrale(errq.^2,dt)/20);
fprintf('Energia dell''errore di quantizzazione con molti bits secondo l''approssimazione: %.3e\n',...
    ((max(x)-min(x))/2^(bits))^2/12);

