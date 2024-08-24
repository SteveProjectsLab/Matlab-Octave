clear 
close all
clc
 syms y(t)
 edo= 2*diff(y,3)+2*diff(y,2)+3*y==sin(t)
% cond1 = y(0) ==1
% cond2 = subs(diff(y,1),y,0)==-2
% cond3 = subs(diff(y,2),y,0)==4
% 
% conds=[cond1 cond2 cond3];
% 
% sol=dsolve(edo,conds)
%%
V=odeToVectorField(edo)

% V =
%                         Y[2]
%                         Y[3]
% sin(t)/2 - (3*Y[1])/2 - Y[3]
%odefun=matlabFunction(V)
%=@(Y,t)[Y(2);Y(3);sin(t)./2.0-Y(1).*(3.0./2.0)-Y(3)]

odefun=@(t,y)[y(2);
             y(3);
             0.5*(-2*y(3)-3*y(2)-3*y(1)+sin(t))];


tspan=[0,40];

y0=[1;-2;4];

% discretizzazione
H=0.01;
figure(1); clf
for h=H
    Nh=fix((tspan(2)-tspan(1))/h);
    [tn,un]=eulero_esp_sys(odefun,tspan,y0,Nh);
    plot(tn,un(:,1),'.--','Displayname',['EE h=',num2str(h)])
    legend('-dynamiclegend')
    hold on
    grid on
    xlabel('t')
    ylabel('x(t)')
    
    [tn4,un4]=rk4(odefun,tspan,y0,Nh);
    plot(tn4,un4(:,1),'.--','Displayname',['RK4 h=',num2str(h)])
    
    pause(1)
end

%% calcolo l'assoluta stabilità

A=[0 1 0;
   0 0 1;
   -1.5 -1.5 -1];
odefun=@(t,y)A*y
lambda=eig(A)

% lambda =
% 
%   -1.0000 + 0.0000i
%    0.0000 + 1.2247i
%    0.0000 - 1.2247i

%% 
figure(2)

[xa,ya]=meshgrid(-3:0.01:1,-3:0.01:3);
z=xa+i*ya;
%R=double(abs(z+1)<1);
R=double(abs(1+z.*(1+z.*(1/2+z.*(1/6+z/24))))<1)
hold on;grid on
contourf(xa,ya,R,1);colormap([1 1 1;0 1 0])

for count=1:3
    xp=real(lambda(count))
    yp=imag(lambda(count))
    line([xp 0],[yp 0],'color','k')
    hold on ;grid on
    plot(xp,yp,'o','MarkerFaceColor','r')
    grid on
end

grid on