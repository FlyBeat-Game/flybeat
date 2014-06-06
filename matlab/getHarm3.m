function m = getHarm3(f,dfh)
    f = f(1:floor(length(f)/2));
    %low pass
    for i=1:floor(100/dfh)
        f(i) = 0;
    end
    %high pass
    for i=floor(1000/dfh):length(f)
        f(i) = 0;
    end
    
    [f,mag] = getMaxs(f,20);

    harmonics = zeros(1,length(f));
    
    for i=1:length(f)
        harmonics(i) = mag(i);
        for j=1:length(f)
            if ((j ~= i) && (f(i) ~= 0) && (f(j) ~= 0))
                a = max(f(j),f(i));
                b = min(f(j),f(i));
                q = a/b;
                diff = abs(q-round(q));
                if (diff < 0.08)
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
