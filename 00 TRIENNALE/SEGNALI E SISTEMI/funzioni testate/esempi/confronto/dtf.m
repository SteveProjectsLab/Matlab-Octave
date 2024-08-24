function [X] = dtf(x,N)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
W=zeros(N);
for n=1:N
    for m=1:N
        W(n,m)=exp(-1j*2*pi*((n-1)*(m-1))/N);
    end
end

X=W*transpose(x);
end

