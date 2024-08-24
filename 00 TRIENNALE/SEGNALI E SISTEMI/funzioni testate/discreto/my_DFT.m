function X = my_DFT(x)

N = length(x);
X = zeros(size(x));
for k = 1:length(X)
    for n = 1:length(x)
        X(k) = X(k) + x(n)*exp(-1j*2*pi*(n-1)*(k-1)/N);
    end
end

