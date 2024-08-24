clear all
clc

A=[-1 5;
    0 -8]
B=[1;0]
C=[1 5]
u=3
xeq=-inv(A)*B*u

% xeq =
% 
%      3
%      0

aval=eig(A)

% aval =
% 
%     -1
%     -8

sys_ss=ss(A,B,C,0)
sys_tf=tf(sys_ss)
% 
% sys_tf =
% 
%     1
%   -----
%   s + 1

%%
s=tf('s')
G=C*inv(s*eye(2)-A)*B

% G =
% 
%     1
%   -----
%   s + 1


R=ctrb(A,B)
rR=rank(R)

O=obsv(A,C)
rO=rank(O)