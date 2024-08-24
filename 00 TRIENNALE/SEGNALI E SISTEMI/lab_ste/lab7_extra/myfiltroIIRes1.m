function y = myfiltroIIRes1(a,x)

y = zeros(size(x));
y(1) = (1-a)*x(1);
for n = 2:length(x)
    y(n) = a*y(n-1)+(1-a)*x(n);
end