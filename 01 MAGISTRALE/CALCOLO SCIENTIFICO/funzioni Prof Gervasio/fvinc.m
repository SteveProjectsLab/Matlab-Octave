function [f]=fvinc(t,y)
% FVINC Function per  l'esempio del pendolo sferico
f=zeros(size(y));
H=2*eye(3); % Hessiana
xp=y(4:6);
mass=1;
G=[0;0;-mass*9.8];  % forza esterna
Gphi=2*y(1:3); % gradiente di Phi
frazione=(mass*xp'*H*xp+G'*Gphi)/(Gphi'*Gphi);
f(1:3)=y(4:6);
f(4:6)=(G-frazione*Gphi)/mass;


