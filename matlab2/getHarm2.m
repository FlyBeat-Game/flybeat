function m = getHarm(f)
    %f = f(1:floor(length(f)/2));
    
    %[f,mag] = getMaxs(f,20);

    harmonics = zeros(1,length(f));
    gcds = zeros(length(f),length(f));
    x = 1;
    
    for i=1:length(f)
        for j=1:length(f)
            if (i ~= j)
                g = gcd(f(i),f(j));
                gcds(i,j) = g;
            end
        end
    end
    gcds
    mode(mode(gcds))
end
