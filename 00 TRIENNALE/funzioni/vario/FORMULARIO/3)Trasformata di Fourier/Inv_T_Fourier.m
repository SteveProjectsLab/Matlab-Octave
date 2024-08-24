function x = Inv_T_Fourier(X, f, t)
%INV_T_FOURIER Summary of this function goes here
%   Detailed explanation goes here
df= f(2)- f(1);
x= zeros(1, length(t));

    for k=1: length(t)
        x(k)=integrale(X.*exp(2*pi*1j*f*t(k)), df);
    end
end

