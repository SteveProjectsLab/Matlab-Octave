function y = myfiltroIIRes2(a,b,x)

y = zeros(size(x));
y(1) = x(1);
y(2) = (a+b)*y(1)+x(2);
for n = 3:length(x)
    y(n) = (a+b)*y(n-1)-a*b*y(n-2)+x(n);
end

