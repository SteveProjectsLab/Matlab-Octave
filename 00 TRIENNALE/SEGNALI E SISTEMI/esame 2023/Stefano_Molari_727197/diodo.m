function y = diodo(x)

a=0.2;

for k=1:length(x)
    if(x(k)>=a)
        y(k)=x(k);
    else
        y(k)=0;
    end
end
