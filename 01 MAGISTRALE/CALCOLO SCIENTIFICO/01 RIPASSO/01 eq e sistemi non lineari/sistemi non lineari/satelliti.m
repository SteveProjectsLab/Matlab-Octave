% dati
rT=6371; % raggio terra in km
rS=42168; % raggio orbite in km
theta=[pi/6;2*pi/9;5*pi/36;pi/3]; 
phi=[pi/6;pi/3;pi/2;2*pi/3];

tS=[0;1e-4;2e-4;5e-5]; % tempi di emissione dei segnali
tR=[0.1203312573558543;
    0.1219281015231533;
    0.1255843020645584;
    0.1364331045023147]; % tempi di ricezione dei segnali

c=299792; % velocita' luce in km/sec

% conversione coordinate sferiche --> cartesiane
S=zeros(4,3); % riga i contiene le coordinate del Satellite i-simo
for i=1:4
    S(i,1)=rS*sin(theta(i))*cos(phi(i)); % x
    S(i,2)=rS*sin(theta(i))*sin(phi(i)); % y
    S(i,3)=rS*cos(theta(i)); % z
end


% definizione funzione F(x) del sistema
% x=[x_r;y_R;z_R;delta]
f=@(x)[sqrt( (S(1,1)-x(1))^2+(S(1,2)-x(2))^2+(S(1,3)-x(3))^2 )-c*(tR(1)-tS(1))-c*x(4); 
       sqrt( (S(2,1)-x(1))^2+(S(2,2)-x(2))^2+(S(2,3)-x(3))^2 )-c*(tR(2)-tS(2))-c*x(4); 
       sqrt( (S(3,1)-x(1))^2+(S(3,2)-x(2))^2+(S(3,3)-x(3))^2 )-c*(tR(3)-tS(3))-c*x(4); 
       sqrt( (S(4,1)-x(1))^2+(S(4,2)-x(2))^2+(S(4,3)-x(3))^2 )-c*(tR(4)-tS(4))-c*x(4)];

% chiamata a Broyden
% prendo come dato iniziale la proiezione del primo satellite sulla terra
x0=[S(1,:)/rS*rT, 0]';  
tol=1.e-9; kmax=100;
B0=eye(4);
[zero,res,niter,ERR]=broyden(f,B0,x0,tol,kmax)

% zero =
%    4.1621e+03
%    1.7240e+03
%    4.5050e+03
%   -2.8327e-12
% res =
%    1.6984e-06
% niter =
%     24
%% rappresentazione dei risultati

% disegno la terra
[x,y,z]=sphere;
figure(1); clf
surf(x*rT,y*rT,z*rT)
hold on
% plotto la posizione dei satelliti
for i=1:4
    plot3(S(i,1),S(i,2),S(i,3),'ko','Markerfacecolor','k')
end
% plotto la posizione del ricevitore
plot3(zero(1),zero(2),zero(3),'ro','Markerfacecolor','r')
grid on