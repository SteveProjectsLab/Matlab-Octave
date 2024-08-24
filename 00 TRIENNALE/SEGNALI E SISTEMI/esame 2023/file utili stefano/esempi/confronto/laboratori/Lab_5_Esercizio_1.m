dt=0.01;
t=-10:dt:10;
addpath ../../0.FUNZIONI/

T1=4;

kDirac=-200:1:200;
Xkdirac=zeros(1,length(kDirac));
for i=1:length(kDirac)
    Xkdirac(i)=1/T1;
end
x1=myConvolution(t.*rect(t/4),serieFourierComplessa(Xkdirac,kDirac,t,T1),t);

Narm=[10 20 30];
x1Approx=zeros(3,length(t));
a0=0;
ak=zeros(1,Narm(1));
bk=zeros(1,Narm(1));

for i=1:Narm(1)
    bk(i)=(-2/(pi*i))*(-1).^i;
end
x1Approx(1,:)=serieFourierReale(a0,ak,bk,T1,t);

k=1:1:Narm(1);
[a02,ak2,bk2]=coeffFourierReali(x1Approx(1,:),t,k,T1);

figure('name','Coefficienti di fourier con 10 armoniche')
subplot(3,1,1); title('Coefficienti $$a_0$$','Interpreter','latex','FontSize',15); grid on; 
hold on 
scatter(1,a0,'filled',LineWidth=2,Color='black'); 
scatter(1,a02,'filled',LineWidth=2,Color='red'); 
hold off
legend('coefficientie vero','coefficiente ricostruito');
subplot(3,1,2); title('Coefficienti $$a_k$$','Interpreter','latex','FontSize',15); grid on;
hold on 
scatter(k,ak,'filled',LineWidth=2,Color='black'); 
scatter(k,ak2,'filled',LineWidth=2,Color='red'); 
hold off
legend('coefficienti veri','coefficienti ricostruiti');
subplot(3,1,3); title('Coefficienti $$b_k$$','Interpreter','latex','FontSize',15); grid on;
hold on 
scatter(k,bk,'filled',LineWidth=2,Color='black'); 
scatter(k,bk2,'filled',LineWidth=2,Color='red'); 
hold off
legend('coefficienti veri','coefficienti ricostruiti');
pause 
close all

a0=0;
ak=zeros(1,Narm(2));
bk=zeros(1,Narm(2));
for i=1:Narm(2)
    bk(i)=(-2/(pi*i))*(-1).^i;
end
x1Approx(2,:)=serieFourierReale(a0,ak,bk,T1,t);

k=1:1:Narm(2);
[a02,ak2,bk2]=coeffFourierReali(x1Approx(2,:),t,k,T1);

figure('name','Coefficienti di fourier con 20 armoniche')
subplot(3,1,1); title('Coefficienti $$a_0$$','Interpreter','latex','FontSize',15); grid on; 
hold on 
scatter(1,a0,'filled',LineWidth=2,Color='black'); 
scatter(1,a02,'filled',LineWidth=2,Color='red'); 
hold off
legend('coefficientie vero','coefficiente ricostruito');
subplot(3,1,2); title('Coefficienti $$a_k$$','Interpreter','latex','FontSize',15); grid on;
hold on 
scatter(k,ak,'filled',LineWidth=2,Color='black'); 
scatter(k,ak2,'filled',LineWidth=2,Color='red'); 
hold off
legend('coefficienti veri','coefficienti ricostruiti');
subplot(3,1,3); title('Coefficienti $$b_k$$','Interpreter','latex','FontSize',15); grid on;
hold on 
scatter(k,bk,'filled',LineWidth=2,Color='black'); 
scatter(k,bk2,'filled',LineWidth=2,Color='red'); 
hold off
legend('coefficienti veri','coefficienti ricostruiti');
pause 
close all

a0=0;
ak=zeros(1,Narm(3));
bk=zeros(1,Narm(3));
for i=1:Narm(3)
    bk(i)=(-2/(pi*i))*(-1).^i;
end
x1Approx(3,:)=serieFourierReale(a0,ak,bk,T1,t);

k=1:1:Narm(3);
[a02,ak2,bk2]=coeffFourierReali(x1Approx(3,:),t,k,T1);

figure('name','Coefficienti di fourier con 30 armoniche')
subplot(3,1,1); title('Coefficienti $$a_0$$','Interpreter','latex','FontSize',15); grid on; 
hold on 
scatter(1,a0,'filled',LineWidth=2,Color='black'); 
scatter(1,a02,'filled',LineWidth=2,Color='red'); 
hold off
legend('coefficientie vero','coefficiente ricostruito');
subplot(3,1,2); title('Coefficienti $$a_k$$','Interpreter','latex','FontSize',15); grid on;
hold on 
scatter(k,ak,'filled',LineWidth=2,Color='black'); 
scatter(k,ak2,'filled',LineWidth=2,Color='red'); 
hold off
legend('coefficienti veri','coefficienti ricostruiti');
subplot(3,1,3); title('Coefficienti $$b_k$$','Interpreter','latex','FontSize',15); grid on;
hold on 
scatter(k,bk,'filled',LineWidth=2,Color='black'); 
scatter(k,bk2,'filled',LineWidth=2,Color='red'); 
hold off
legend('coefficienti veri','coefficienti ricostruiti');
pause 
close all

figure('name','Ricostruzione del segnale x1(t)=t.rect(t/4)*delta(t-4k)')
subplot(2,2,1); plot(t,real(x1), ...
    ...
    ...
    LineWidth=2,Color='green'); title('Segnale vero','Interpreter','latex','FontSize',15); grid on;
subplot(2,2,2); plot(t,x1Approx(1,:),LineWidth=2,Color='red'); title('10 armoniche','Interpreter','latex','FontSize',15); grid on;
subplot(2,2,3); plot(t,x1Approx(2,:),LineWidth=2,Color='black'); title('20 armoniche','Interpreter','latex','FontSize',15); grid on;
subplot(2,2,4); plot(t,x1Approx(3,:),LineWidth=2,Color='blue'); title('30 armoniche','Interpreter','latex','FontSize',15); grid on;
pause
close all

figure('name','Segnali differenza con quello reale')
subplot(3,1,1); plot(t,(real(x1)-x1Approx(1,:)),LineWidth=2,Color='red'); title('10 armoniche','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,2); plot(t,(real(x1)-x1Approx(2,:)),LineWidth=2,Color='black'); title('20 armoniche','Interpreter','latex','FontSize',15); grid on;
subplot(3,1,3); plot(t,(real(x1)-x1Approx(3,:)),LineWidth=2,Color='blue'); title('30 armoniche','Interpreter','latex','FontSize',15); grid on;
pause 
close all


