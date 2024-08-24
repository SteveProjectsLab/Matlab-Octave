
dt=0.01;
t=-10:dt:10;

addpath ../../0.FUNZIONI/

x2=abs(cos((2*pi*t/4)-(pi/4)));
T2=2;

Narm=[10 20 30];
x2Approx=zeros(3,length(t));

k=-Narm(1):1:Narm(1);
Xk=zeros(1,length(k));
for h=1:length(k)
    Xk(h)=(2/pi)*(((-1).^(k(h)+1))/(4*(k(h).^2)-1))*exp(-1j*k(h)*pi/2);
end

x2Approx(1,:)=serieFourierComplessa(Xk,k,t,T2);

Xk2=coeffFourierComplessi(x2Approx(1,:),t,k,T2);
figure('name','Coefficienti di fourier con 10 armoniche')
subplot(2,1,1); title('Coefficienti $$Re{Xk}$$','Interpreter','latex','FontSize',15); grid on; 
hold on 
scatter(k,real(Xk),'filled',LineWidth=2,Color='black'); 
scatter(k,real(Xk2),'filled',LineWidth=2,Color='red'); 
hold off
legend('parte reale coefficientie vero','parte reale coefficiente ricostruito');
subplot(2,1,2); title('Coefficienti $$Im{Xk}$$','Interpreter','latex','FontSize',15); grid on; 
hold on 
scatter(k,imag(Xk),'filled',LineWidth=2,Color='black'); 
scatter(k,imag(Xk2),'filled',LineWidth=2,Color='red'); 
hold off
legend('parte immaginaria coefficientie vero','parte immaginaria coefficiente ricostruito');
pause
close all

k=-Narm(2):1:Narm(2);
Xk=zeros(1,length(k));
for h=1:length(k)
    Xk(h)=(2/pi)*(((-1).^(k(h)+1))/(4*(k(h).^2)-1))*exp(-1j*k(h)*pi/2);
end

x2Approx(2,:)=serieFourierComplessa(Xk,k,t,T2);

Xk2=coeffFourierComplessi(x2Approx(2,:),t,k,T2);
figure('name','Coefficienti di fourier con 20 armoniche')
subplot(2,1,1); title('Coefficienti $$Re{Xk}$$','Interpreter','latex','FontSize',15); grid on; 
hold on 
scatter(k,real(Xk),'filled',LineWidth=2,Color='black'); 
scatter(k,real(Xk2),'filled',LineWidth=2,Color='red'); 
hold off
legend('parte reale coefficientie vero','parte reale coefficiente ricostruito');
subplot(2,1,2); title('Coefficienti $$Im{Xk}$$','Interpreter','latex','FontSize',15); grid on; 
hold on 
scatter(k,imag(Xk),'filled',LineWidth=2,Color='black'); 
scatter(k,imag(Xk2),'filled',LineWidth=2,Color='red'); 
hold off
legend('parte immaginaria coefficientie vero','parte immaginaria coefficiente ricostruito');
pause
close all

k=-Narm(3):1:Narm(3);
Xk=zeros(1,length(k));
for h=1:length(k)
    Xk(h)=(2/pi)*(((-1).^(k(h)+1))/(4*(k(h).^2)-1))*exp(-1j*k(h)*pi/2);
end

x2Approx(3,:)=serieFourierComplessa(Xk,k,t,T2);

Xk2=coeffFourierComplessi(x2Approx(3,:),t,k,T2);
figure('name','Coefficienti di fourier con 30 armoniche')
subplot(2,1,1); title('Coefficienti $$Re{Xk}$$','Interpreter','latex','FontSize',15); grid on; 
hold on 
scatter(k,real(Xk),'filled',LineWidth=2,Color='black'); 
scatter(k,real(Xk2),'filled',LineWidth=2,Color='red'); 
hold off
legend('parte reale coefficientie vero','parte reale coefficiente ricostruito');
subplot(2,1,2); title('Coefficienti $$Im{Xk}$$','Interpreter','latex','FontSize',15); grid on; 
hold on 
scatter(k,imag(Xk),'filled',LineWidth=2,Color='black'); 
scatter(k,imag(Xk2),'filled',LineWidth=2,Color='red'); 
hold off
legend('parte immaginaria coefficientie vero','parte immaginaria coefficiente ricostruito');
pause
close all

figure('name','Ricostruzione del segnale x2(t)=|cos((2*pi*t/4)-(pi/4))|')
subplot(2,2,1); plot(t,x2,LineWidth=2,Color='green'); title('Segnale vero','Interpreter','latex','FontSize',15); grid on;
subplot(2,2,2); plot(t,real(x2Approx(1,:)),LineWidth=2,Color='red'); title('10 armoniche','Interpreter','latex','FontSize',15); grid on;
subplot(2,2,3); plot(t,real(x2Approx(2,:)),LineWidth=2,Color='black'); title('20 armoniche','Interpreter','latex','FontSize',15); grid on;
subplot(2,2,4); plot(t,real(x2Approx(3,:)),LineWidth=2,Color='blue'); title('30 armoniche','Interpreter','latex','FontSize',15); grid on;
pause
close all

figure('name','Segnali differenza con quello reale')
subplot(3,1,1); plot(t,(x2-real(x2Approx(1,:))),LineWidth=2,Color='red'); title('10 armoniche','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,2); plot(t,(x2-real(x2Approx(2,:))),LineWidth=2,Color='black'); title('20 armoniche','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,3); plot(t,(x2-real(x2Approx(3,:))),LineWidth=2,Color='blue'); title('30 armoniche','Interpreter','latex','FontSize',15); grid on;
pause 
close all