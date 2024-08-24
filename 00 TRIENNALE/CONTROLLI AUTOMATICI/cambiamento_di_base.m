clc
clear all;
close all;

%cambiamento di base
n=2;
fprintf('Cambiamento di Base\n');
fprintf('inserire A,B,C...\n');
A=input('A= ');
B=input('B= ');
C=input('C= ');
fprintf('se non vuoi inserire T premi 0\n');

T=input('T= ');
if(T==0)
    T = [1 1;1 -1]; 
end
%A = [-1 1;1 -1];
%B = [1 0];
%C = [0 1];



Tinv = inv(T);
sum=0;


%calcolo A tilde
Atilde=T*A*Tinv;

Btilde= zeros(n,1);
%calcolo B tilde
for i=1:n
    for j=1:n
    sum = sum + T(i,j)*B(j);
    end
Btilde(i)=sum;
sum=0;
end
Ctilde= zeros(n,1);
%calcolo C tilde
for i=1:n
    for j=1:n
    sum = sum + Tinv(i,j)*C(j);
    end
Ctilde(i)=sum;
sum=0;
end

fprintf('\nA tilde(per colonne)\n');
fprintf(' %.2f ',Atilde);
fprintf('\nB tilde\n');
fprintf(' %.2f ',Btilde);
fprintf('\nC tilde\n');
fprintf(' %.2f ',Ctilde);
pause;