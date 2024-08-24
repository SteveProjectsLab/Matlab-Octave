function S = serieFourierReale(a0,ak,bk,T,t)
xc=zeros(1,length(t));
xs=zeros(1,length(t));

for i=1:length(ak)
    xc= xc + ak(i)*cos(2*pi*i*t/T);
end
for i=1:length(bk)
    xs= xs + bk(i)*sin(2*pi*i*t/T);
end
S=a0+2*xc+2*xs;
end