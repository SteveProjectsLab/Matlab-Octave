clear
close all
clc

dt = 0.01;
t = -10:dt:10;
df = dt;
f = -15:df:15;

x = 8*sinc(t/2); % Cambiare il segnale a seconda dell'esercizio
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
    
    % Calcolo TdF
    Xc = T_Fourier(xc,t,f);
    figure
    plot(f,abs(Xc)), title(sprintf('Spettro segnale campionato Xc, con Tc=%.2f',Tc))
    
    % Interpolazione ideale
    xr_i = zeros(1,length(t));
    for k = 1:length(tsample)
        xr_i = xr_i + xc(tsample(k))*sinc((t-t(tsample(k)))/Tc);
    end
    figure
    plot(t,xr_i,t,x), title(sprintf('Segnale ricostruito idealmente xr_i, con Tc=%.2f',Tc))
    fprintf('Energia dell''errore di ricostruzione con interpolatore ideale e Tc=%.3f: %.3f\n',...
        Tc, integrale(abs(x-xr_i).^2,dt))
    
    % ZOH interpolazione
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