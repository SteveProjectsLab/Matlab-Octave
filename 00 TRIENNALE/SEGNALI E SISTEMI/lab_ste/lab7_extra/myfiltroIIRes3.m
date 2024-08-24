function y = myfiltroIIRes3(a,b,G,x)


y = zeros(size(x));
y(1) = G*(b(1)*x(1));
y(2) = G*(b(2)*x(1)+b(1)*x(2)+a(1)*y(1));
y(3) = G*(b(3)*x(1)+b(2)*x(2)+b(1)*x(3)+a(1)*y(2)+a(2)*y(2));
for n = 4:length(x)
    y(n) = G*(b(3)*x(n)+b(2)*x(n-1)+b(1)*x(n-2)+...
        a(1)*y(n-1)+a(2)*y(n-2)+a(3)*y(n-3));
end