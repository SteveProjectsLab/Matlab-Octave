
function x = sinc(t)
x=zeros(length(t));
x=(sin(pi*t))./(pi*t);
x(t==0)=1;
end