function y = ConvInd(x1,x2)

L1 = length(x1);
L2 = length(x2);
x1 = [x1, zeros(1,L2-1)];
x2 = [x2, zeros(1,L1-1)];
y = my_IDFT(my_DFT(x1).*my_DFT(x2));