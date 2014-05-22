function s = commas(a)
    s = '';
    for i=1:length(a)-1
        s = strcat(s,num2str(a(i)));
        s = strcat(s,',');
    end
    s = strcat(s,num2str(a(i)));
end
