% esercizio sulla cancellazione
x=linspace(0.996,1.004,10000);
p1=(x-1).^6;
p2=x.^6-6*x.^5+15*x.^4-20*x.^3+15*x.^2-6*x+1;
p3=1+x.*(-6+x.*(15+x.*(-20+x.*(15+x.*(-6+x)))));

figure(1); clf

plot(x,p2,x,p3,x,p1)
legend('p2','p3','p1')
grid on
xlabel('x')
ylabel('y')