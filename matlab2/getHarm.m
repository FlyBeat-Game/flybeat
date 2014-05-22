function m = getHarm(f)
    m = getMax(f);
    for i=1:length(f)
        for j=1:length(f)
            d = f(i)/f(j);
            l = log2(d);
            diff = abs(l-int32(l));
            if (diff > 0.05)
                f(i)
                %cenas
            end
        end
    end
end
