function x = Inv_T_Fourier(X,f,t)
% INVERSE FOURIER TRANSFORM

df = f(2)-f(1);
% x = zeros(size(t));
% 
% for k = 1:length(t)
%     x(k) = integrale(X.*exp(1i*2*pi*t(k)*f),df);
% end
x = df*X*exp(1i*2*pi*f'*t);
