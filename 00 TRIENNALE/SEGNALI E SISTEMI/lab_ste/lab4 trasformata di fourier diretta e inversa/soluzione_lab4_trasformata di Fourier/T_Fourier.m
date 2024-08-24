function X = T_Fourier(x,t,f)
% FOURIER TRANSFORM 

dt = t(2)-t(1);
% X = zeros(size(f));
% 
% for k = 1:length(f)
%     X(k) = integrale(x.*exp(-1i*2*pi*f(k)*t),dt);
% end
X = dt*x*exp(-1i*2*pi*t'*f);