clc
clear all
close all

syms rs xs

fs=0.5*(rs+1)+xs^2

r=-2:0.1:0;

for j=1:length(r)
    f1=subs(fs,rs,r(j));
    xeqs=solve(f1==0);
    xeqv=double(xeqs);
    Js=jacobian(f1);
    for i=1:length(xeqv)
        if isreal(xeqv(i))
            aval=eig(double(subs(Js,xs,xeqv(i))));
            if aval<0
                plot(r(j),xeqv(i),'bo')
            else
                plot(r(j),xeqv(i),'r*')
            end
            hold on
        end
    end
end


% Simulare in sistema per x(0) = 0.1, r = r − 0.1, r = r, r = r + 0.1 
% e graficare l evoluizone dello stato nei 3 casi. 
x0=0.1;
rb=-1; % r in cui c'è la biforcazione, lo capisco dal plot
r_sim=rb-0.1;
figure
out=sim("Es2_8_sim")
plot(out.tout,out.x_sim)
hold on


    