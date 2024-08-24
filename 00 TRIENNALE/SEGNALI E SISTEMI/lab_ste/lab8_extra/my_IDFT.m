function x = my_IDFT(X)

N = length(X);
x = zeros(size(X));
for n = 1:length(x)
    for k = 1:length(X)
        x(n) = x(n) + X(k)*exp(1j*2*pi*(n-1)*(k-1)/N);
    end
end
x = x/N;