function X = my_DFT_mat(x)

N = length(x);
F = ones(N);
for r = 2:N
    F(r,:) = exp(-1i*2*pi/N*(0:r-1:(r-1)*(N-1)));
end
X = x*F.';
