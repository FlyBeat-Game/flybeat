function [maxs, peaks] = getMaxs(x,n)
   if (n > length(x))
       n = length(x);
   end
   
   maxs = zeros(1,n);
   peaks = zeros(1,n);
   for i=1:n
       m = getMax(x);
       maxs(i) = m;
       if (m ~= 0)
        peaks(i) = x(m);
        x(m) = 0;
       end
   end
end
