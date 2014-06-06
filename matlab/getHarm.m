function m = getHarm(f)
    f = f(1:floor(length(f)/2));
    
    [f,mag] = getMaxs(f,20);

    harmonics = zeros(1,length(f));
    
    for i=1:length(f)
        harmonics(i) = mag(i);
        for j=1:length(f)
            if ((j ~= i) && (f(i) ~= 0) && (f(j) ~= 0))
                d = f(i)/f(j);
                l = log2(d);
                diff = abs(l-round(l));
                if (diff < 0.05)
                    harmonics(i) = harmonics(i) + mag(j);
                    f(j) = 0;
                end
            end
        end
    end
    
    index = getMax(harmonics);
    m = 0;
    if (index ~= 0)
        m = f(index);
    end
end
