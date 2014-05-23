function maxs = getMaxs(x,n)
   if (n > length(x))
       n = length(x);
   end
   
   maxs = zeros(1,n);
   for i=1:n
       m = getMax(x);
       maxs(i) = m; %x(m);
       if (m ~= 0)
        x(m) = 0;
       end
   end
end
