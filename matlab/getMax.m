function m = getMax(x)
    m = 0;
    l = 0;
    for i=1:length(x)/2
        if x(i) > l
            l = x(i);
            m = i;
        end
    end
end
