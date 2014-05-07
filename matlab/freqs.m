function f = freqs(s)
    len = size(s);
    f = zeros(1,len(2));
    for i=1:len(2)
        f(i) = getMax(s(:,i));
    end
end