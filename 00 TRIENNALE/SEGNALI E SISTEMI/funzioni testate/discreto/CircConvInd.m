function y = CircConvInd(x1,x2,N)

x1 = [x1, zeros(1,N-length(x1))];
x2 = [x2, zeros(1,N-length(x2))];
y = my_IDFT(my_DFT(x1).*my_DFT(x2));