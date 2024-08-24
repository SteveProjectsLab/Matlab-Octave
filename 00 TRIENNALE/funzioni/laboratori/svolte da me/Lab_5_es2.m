clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %PARTE 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%visualizzare i fenomeni di gibbs

%filtro passa basso, finestrarlo con rect diversi
fprintf('\n\nLAB 5 es 2.1\n\n');
B = 2;
h = 2*B*sinc(2*B*t); H = rect(f/(2*B));
h1 = h.*rect(t/4); H1 = T_Fourier(h1,t,f);
h2 = h.*rect(t/10); H2 = T_Fourier(h2,t,f);
h3 = h; H3 = T_Fourier(h3,t,f);

figure(1),set(1, 'WindowStyle', 'docked')
subplot(3,2,1), plot(t,h1), title('h1'),grid on
subplot(3,2,2), plot(f,real(H1)), title('H1'),grid on
subplot(3,2,3), plot(t,h2), title('h2'),grid on
subplot(3,2,4), plot(f,real(H2)), title('H2'),grid on
subplot(3,2,5), plot(t,h3), title('h3'),grid on
subplot(3,2,6), plot(f,real(H3)), title('H3'),grid on

fprintf('Massima sovraelongazione di H1 = %f\n', max(real(H1)))
fprintf('Massima sovraelongazione di H2 = %f\n', max(real(H2)))
fprintf('Massima sovraelongazione di H3 = %f\n', max(real(H3)))

fprintf('Energia della differenza tra H e H1 = %f\n', integrale(abs(H-H1).^2, df))
fprintf('Energia della differenza tra H e H2 = %f\n', integrale(abs(H-H2).^2, df))
fprintf('Energia della differenza tra H e H3 = %f\n', integrale(abs(H-H3).^2, df))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %PARTE 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%analoga alla parte 1 però con B=10
fprintf('\n\nLAB 5 es 2.2\n\n');
Bb = 10;
hb = 2*Bb*sinc(2*Bb*t); Hb = rect(f/(2*Bb));
h1b = h.*rect(t/4); H1b = T_Fourier(h1b,t,f);
h2b = h.*rect(t/10); H2b = T_Fourier(h2b,t,f);
h3b = h; H3b = T_Fourier(h3b,t,f);

figure(2),set(2, 'WindowStyle', 'docked')
subplot(3,2,1), plot(t,h1b), title('h1'),grid on
subplot(3,2,2), plot(f,real(H1b)), title('H1'),grid on
subplot(3,2,3), plot(t,h2b), title('h2'),grid on
subplot(3,2,4), plot(f,real(H2b)), title('H2'),grid on
subplot(3,2,5), plot(t,h3b), title('h3'),grid on
subplot(3,2,6), plot(f,real(H3b)), title('H3'),grid on

fprintf('Massima sovraelongazione di H1 = %f\n', max(real(H1b)))
fprintf('Massima sovraelongazione di H2 = %f\n', max(real(H2b)))
fprintf('Massima sovraelongazione di H3 = %f\n', max(real(H3b)))

fprintf('Energia della differenza tra H e H1 = %f\n', integrale(abs(Hb-H1b).^2, df))
fprintf('Energia della differenza tra H e H2 = %f\n', integrale(abs(Hb-H2b).^2, df))
fprintf('Energia della differenza tra H e H3 = %f\n', integrale(abs(Hb-H3b).^2, df))
