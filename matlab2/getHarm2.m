function m = getHarm2(f)
    f = f(1:floor(length(f)/2));
    
    [f,mag] = getMaxs(f,20);

    harmonics = zeros(1,length(f));
    gcds = zeros(length(f),length(f));
    g = zeros(1,20);
    
    for i=1:length(f)
        for j=1:length(f)
            if (i ~= j)
                gcds(i,j) = gcd(f(i),f(j));
            end
        end
    end
    m = 0;
    gcds = gcds./(gcds~=0);
    gcds = gcds./(gcds~=1);
    m = mode(gcds(:));
    if (m == Inf)
        m = 0;
    end
end

%40.44
%22.9
%8.7
%6.91
%5.67

