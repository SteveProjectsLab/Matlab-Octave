function f = sinc(t)
    f = sin(pi*t)./(pi*t);
    f(t==0) = 1;
end