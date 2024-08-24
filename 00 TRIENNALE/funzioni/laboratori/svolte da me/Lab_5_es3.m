clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %PARTE 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
C = 1/1000;
ft = 1/(2*pi*R*C); % Occhio, aggiungere 2pi
H = 1./(1+1j*2*pi*f*R*C);

fprintf('\n\nLAB 5 es 3.1\n\n');
figure
subplot(2,1,1), plot(f,abs(H)), title('Modulo di H')
subplot(2,1,2), plot(f,angle(H)), title('Fase di H')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %PARTE 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('\n\nLAB 5 es 3.2\n\n');
flog = ft/100:df:ft*100;
Hlog = 1./(1+1j*2*pi*flog*R*C);

figure
subplot(2,1,1), loglog(flog,abs(Hlog)), title('Modulo di H'), grid on
subplot(2,1,2), semilogx(flog,angle(Hlog)), title('Fase di H'), grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %PARTE 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\n\nLAB 5 es 3.3\n\n');
tau = t;
dtau = dt;
h = Inv_T_Fourier(H,f,tau);
y = zeros(1,length(t));
for k = 1:length(t)
    y(k) = integrale(h.*gradino(-tau+t(k)), dtau);
end
figure
plot(t,abs(h)), title('h')
figure
plot(t,abs(y)), title('y')
