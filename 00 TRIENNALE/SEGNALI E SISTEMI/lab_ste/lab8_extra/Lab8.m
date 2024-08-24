clear
close all
clc

%%
% Es. 1i
N = 16;
n = 0:N-1;
k = 0:N-1;
x1 = 2.^-n;
X1 = my_DFT(x1);
X1_fft = fft(x1);
figure
subplot(3,1,1), stem(n,x1), title('x_1[n]')
subplot(3,1,2), stem(n,abs(X1)), hold on, stem(n,imag(X1),'x'), title('X_1[k] con my DFT')
subplot(3,1,3), stem(n,abs(X1_fft)), hold on, stem(n,imag(X1_fft),'x'), title('X_1[k] con FFT')

%%
close all;
% Es. 1ii
N_vec = [8 12 16 20];
for N = 20
    n = 0:N-1;
    k = 0:N-1;
    x2 = cos(pi/4*n);

    df=0.001;
    f = 0:df:1;
    E = zeros(length(n),length(f));
    for k = 1:length(f)
        E(:,k) = exp(-1i*2*pi*f(k)*n);
    end

    X2 = my_DFT(x2);
    X2_fft = fft(x2);
    figure
%    subplot(3,1,1), stem(n,x2), title(sprintf('x_2[n] con N = %d',N))
    %subplot(3,1,2), 
    stem(n/N,abs(X2)), hold on, stem(n/N,imag(X2),'x'), title('X_2[k] con my DFT')
    X2_DTFT = x2*E;
    plot(f,abs(X2_DTFT));

    %subplot(3,1,3), stem(n,abs(X2_fft)), hold on, stem(n,imag(X2_fft),'x'), title('X_2[k] con FFT')
end


%%
close all
clear
clc
% ES. 2i

N_vec = [8 16 32 64 128];

for N = N_vec
    n = 0:N-1;

    df=0.001;
    f = 0:df:1;
    E = zeros(length(n),length(f));
    for k = 1:length(f)
        E(:,k) = exp(-1i*2*pi*f(k)*n);
    end

    x = [ones(1,8), zeros(1,N-8)];
    X = my_DFT(x);
    figure, stem(n,abs(X)), hold on, stem(n,imag(X),'x'), title(sprintf('X[k] con N = %d',N))
end

%%
% ES. 2ii
L_vec = 1:10;
for L = L_vec
    x = ones(1,8);
%     xL = zeros(1,L*length(x));
%     xL(1:L:end) = x;
%     n = 0:length(xL)-1;
    xL = zeros(1,128);
    xL(1:L:L*length(x)) = x;    
    n = 0:127;
    XL = my_DFT(xL);
    figure, stem(n,abs(XL))%, hold on, stem(n,imag(XL),'x'),
    title(sprintf('X_L[k] con L = %d',L))
end


%%
close all
clear
clc
% Es. 3i
x1 = rand(1,8);
x2 = rand(1,5);
N = 8;
n = 0:N-1;
y_my_cconv = CircConvInd(x1,x2,N);
y_cconv = cconv(x1,x2,N);
stem(n,abs(y_my_cconv - y_cconv)) % L'errore è zero, OK

% Es. 3ii
n = 0:length(x1)+length(x2)-2;
y_my_conv = ConvInd(x1,x2);
y_conv = conv(x1,x2);
figure, stem(n,abs(y_my_conv-y_conv)) % L'errore è zero, OK