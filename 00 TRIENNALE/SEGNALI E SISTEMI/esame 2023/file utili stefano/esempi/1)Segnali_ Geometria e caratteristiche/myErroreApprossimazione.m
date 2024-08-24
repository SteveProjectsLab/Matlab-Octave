function y = myErroreApprossimazione(x, Appr_x, dt)
%MYERROREAPPROSSIMAZIONE Summary of this function goes here
%   Detailed explanation goes here
y = myNorm((x-Appr_x), dt).^2;

end

