function [freqs,amps] = getFreqs(f,fs,wstep,start)
    dfh = fs/wstep;
    
    s = size(f);
    freqs = zeros(1,s(2));
    amps = zeros(1,s(2));
    
    for i=1:s(2)
        amps(i) = max(f(:,i))/wstep;
        index = getHarm3(f(:,i),dfh);
        freqs(i) = index*dfh;
        if (freqs(i) < start)
            freqs(i) = 0;
        end
    end
end
