dt=0.01;
df=0.01;
t=-10:dt:10;
f=-15:df:15;
addpath /Users/nicolatrotti/Desktop/MATLAB/SEGNALI/0.FUNZIONI/

B=2;
H=rect(f/(2*B));
h=2*B*sinc(2*B*t);

h1=h.*rect(t/4);
h2=h.*rect(t/10);
h3=h.*rect(t/20);

H1=trasFourier(h1,t,f);
H2=trasFourier(h2,t,f);
H3=trasFourier(h3,t,f);

figure('name','Risposta all impulso h e risposta in frequenza H')
subplot(3,1,1); plot(t,h,LineWidth=2,Color='red'); title('$$h(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,2); plot(f,real(H),LineWidth=2,Color='black'); title('$$Re{H(f)}$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,3); plot(f,imag(H),LineWidth=2,Color='blue'); title('$$Im{H(f)}$$','Interpreter','latex','FontSize',15); grid on;
pause

figure('name','Risposta all impulso h1 e risposta in frequenza H1')
subplot(3,1,1); plot(t,h1,LineWidth=2,Color='red'); title('$$h_1(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,2); plot(f,real(H1),LineWidth=2,Color='black'); title('$$Re{H_1(f)}$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,3); plot(f,imag(H1),LineWidth=2,Color='blue'); title('$$Im{H_1(f)}$$','Interpreter','latex','FontSize',15); grid on;
pause

figure('name','Risposta all impulso h2 e risposta in frequenza H2')
subplot(3,1,1); plot(t,h2,LineWidth=2,Color='red'); title('$$h_2(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,2); plot(f,real(H2),LineWidth=2,Color='black'); title('$$Re{H_2(f)}$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,3); plot(f,imag(H2),LineWidth=2,Color='blue'); title('$$Im{H_2(f)}$$','Interpreter','latex','FontSize',15); grid on;
pause

figure('name','Risposta all impulso h3 e risposta in frequenza H3')
subplot(3,1,1); plot(t,h3,LineWidth=2,Color='red'); title('$$h_3(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,2); plot(f,real(H3),LineWidth=2,Color='black'); title('$$Re{H_3(f)}$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,3); plot(f,imag(H3),LineWidth=2,Color='blue'); title('$$Im{H_3(f)}$$','Interpreter','latex','FontSize',15); grid on;
pause

% CALCOLO DELLO SCOSTAMENTO DELLA RISPSPOSTA IN FREQUENZA

E1 = integrale(abs(H1-H).^2,df);
E2 = integrale(abs(H2-H).^2,df);
E3 = integrale(abs(H3-H).^2,df);

fprintf('==== B=2 ====\n');
fprintf('La risposta in frequenza H1 si discosta da H di: %f\n',E1);
fprintf('La risposta in frequenza H2 si discosta da H di: %f\n',E2);
fprintf('La risposta in frequenza H3 si discosta da H di: %f\n',E3);

% PARTE 2 CON B CAMBIATO

B=10;
H=rect(f/(2*B));
h=2*B*sinc(2*B*t);

h1=h.*rect(t/4);
h2=h.*rect(t/10);
h3=h.*rect(t/20);

H1=trasFourier(h1,t,f);
H2=trasFourier(h2,t,f);
H3=trasFourier(h3,t,f);

figure('name','Risposta all impulso h e risposta in frequenza H')
subplot(3,1,1); plot(t,h,LineWidth=2,Color='red'); title('$$h(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,2); plot(f,real(H),LineWidth=2,Color='black'); title('$$Re{H(f)}$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,3); plot(f,imag(H),LineWidth=2,Color='blue'); title('$$Im{H(f)}$$','Interpreter','latex','FontSize',15); grid on;
pause

figure('name','Risposta all impulso h1 e risposta in frequenza H1')
subplot(3,1,1); plot(t,h1,LineWidth=2,Color='red'); title('$$h_1(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,2); plot(f,real(H1),LineWidth=2,Color='black'); title('$$Re{H_1(f)}$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,3); plot(f,imag(H1),LineWidth=2,Color='blue'); title('$$Im{H_1(f)}$$','Interpreter','latex','FontSize',15); grid on;
pause

figure('name','Risposta all impulso h2 e risposta in frequenza H2')
subplot(3,1,1); plot(t,h2,LineWidth=2,Color='red'); title('$$h_2(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,2); plot(f,real(H2),LineWidth=2,Color='black'); title('$$Re{H_2(f)}$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,3); plot(f,imag(H2),LineWidth=2,Color='blue'); title('$$Im{H_2(f)}$$','Interpreter','latex','FontSize',15); grid on;
pause

figure('name','Risposta all impulso h3 e risposta in frequenza H3')
subplot(3,1,1); plot(t,h3,LineWidth=2,Color='red'); title('$$h_3(t)$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,2); plot(f,real(H3),LineWidth=2,Color='black'); title('$$Re{H_3(f)}$$','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,3); plot(f,imag(H3),LineWidth=2,Color='blue'); title('$$Im{H_3(f)}$$','Interpreter','latex','FontSize',15); grid on;
pause

% CALCOLO DELLO SCOSTAMENTO DELLA RISPSPOSTA IN FREQUENZA

E1 = integrale(abs(H1-H).^2,df);
E2 = integrale(abs(H2-H).^2,df);
E3 = integrale(abs(H3-H).^2,df);

fprintf('\n==== B=10 ====\n');
fprintf('La risposta in frequenza H1 si discosta da H di: %f\n',E1);
fprintf('La risposta in frequenza H2 si discosta da H di: %f\n',E2);
fprintf('La risposta in frequenza H3 si discosta da H di: %f\n',E3);