function yk = myshift(y,k) % shift k positions to the right 

k = floor(k);
yk = zeros(size(y));

% check for 1D, convert to row
if size(y,1)>1
    y = y';
end
if size(y,1)>1
    fprintf('myshift: not a vector!\n')
    return; 
end

if k>=0
    yk = [zeros(1,k) y(1:end-k)];
else
    yk = [y(-k+1:end) zeros(1,-k)];
end