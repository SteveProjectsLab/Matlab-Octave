function y = diodo2(x, t)
%DIODO2 Summary of this function goes here
%   Detailed explanation goes here
a=0.2;
origine= 1101 ; %% fa in modo che parta da t=1;
for k= origine: length(t)
if (x <a || t(k)<1)
    y=0;
elseif( x>=a && t(k)>=1)
    y=x;
end
end

