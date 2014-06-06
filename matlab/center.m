function [cc] = center(y)
    l = y(:,1);
    r = y(:,2);
    cc = l+r;
    d = abs(l-r);
    for i=1:length(l)
        if (cc(i) > 0)
            cc(i) = cc(i) + d(i);
        else
            cc(i) = cc(i) - (i);
        end
    end
end
