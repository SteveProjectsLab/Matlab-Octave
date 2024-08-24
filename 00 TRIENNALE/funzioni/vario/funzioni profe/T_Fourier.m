function X = T_Fourier(x,t,f)

dt = t(2)-t(1);
X = zeros(1,length(f));
for k = 1:length(f)
    X(k) = integrale(x.*exp(-1j*2*pi*t*f(k)),dt);
end