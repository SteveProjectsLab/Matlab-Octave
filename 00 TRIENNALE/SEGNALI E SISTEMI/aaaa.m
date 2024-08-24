% sinc traslati------------------------------------------------------------
for k=0:10
    
    x(k)= x+sinc(k/3);
    
end

plot(t,x, 'black'),grid on, 