clear
close all
clc

dt = 0.01;
t = -10:dt:10;

x = sin(pi/2*t);
xq = myQuant(x,2);

figure
plot(t,x,t,xq), legend('x','xq'), title('Test')

% Es. 2
x = 0.5*t.^3 + 5*t.^2 -2*(t+10).^2 + 20;
figure
plot(t,x)

vec_bit = [2 4 8 16];
for k = 1:length(vec_bit)
    b = vec_bit(k);
    xq = myQuant(x,b);
    errq = x-xq;
    figure
    plot(t,x,t,xq), legend('x','xq'), title(sprintf('Segnale quantizzato %d bits',b))
    figure
    plot(t,errq), title(sprintf('Segnale errore di quantizzazione %d bits',b))
    fprintf('Potenza media dell''errore di quantizzazione con %d bits: %f\n', b, ...
        integrale(errq.^2,dt)/(t(end)-t(1)))
end












