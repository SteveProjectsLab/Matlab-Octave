function x = Inv_T_Fourier(X,f,t)

df = f(2)-f(1);
x = zeros(1,length(t));
for k = 1:length(t)
    x(k) = integrale(X.*exp(1j*2*pi*f*t(k)), df);
end