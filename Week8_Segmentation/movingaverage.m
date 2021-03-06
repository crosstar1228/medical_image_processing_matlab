function g = movingaverage(f, n, K)
f = double(f);
[M, N] = size(f);

if(n<1) || (rem(n,1) ~=0)
     error('n must be an integer >= 1');
end

if K<0 || K>1
    error('K must be a fraction in the range [0,1].'); 
end
     
f(2:2:end, :) = fliplr(f(2:2:end, :));

f = f';
f = f(:)';

maf = ones(1,n)/n;  % 1D moving average filter
ma = filter(maf, 1, f);  % compute moving average

g = f> K*ma;
g = reshape(g, N, M)';
g(2:2:end, :) = fliplr(g(2:2:end, :));
