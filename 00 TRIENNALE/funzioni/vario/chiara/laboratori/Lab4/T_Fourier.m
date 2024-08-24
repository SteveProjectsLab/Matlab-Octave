function X = T_Fourier(x, t, f)
%T_FOURIER Summary of this function goes here
%   Detailed explanation goes here

dt= t(2)-t(1);
X= zeros (1, length(f)); %inizializzo la trasformata di fourier
    for k= 1: length(f) %scorro tutte le frequenze
        X(k)= integrale(x.*exp( -2*pi*1j*t*f(k)), dt);  
        %con f(k) scorro il vettore delle frequenze
    end
end

