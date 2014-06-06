function m = hps(f,fs)
    c = ifft(log(abs(f)+eps));
    ms2=floor(fs*0.002);
    ms20=floor(fs*0.01);
    [maxi,idx]=max(abs(c(ms2:ms20)));
    m = fs/(ms2+idx-1);
end
