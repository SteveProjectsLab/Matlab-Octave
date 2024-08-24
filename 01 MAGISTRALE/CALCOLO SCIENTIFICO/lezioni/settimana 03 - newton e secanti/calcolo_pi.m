function f = calcolo_pi(N)
%FUNSIONE_PER_PI Summary of this function goes here
%   Detailed explanation goes here
f=zeros(1,N);
f(2)=2;
    for n=2:N-1
        f(n+1)=2^(n-0.5)*(sqrt(1-(sqrt(1-(4^(1-n)*f(n)^2)))));
    end

% calcolo vettore errori
e=abs(f-pi)/pi;

end
