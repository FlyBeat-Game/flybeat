function spec = stfft(x,fs,timeWindow,timeStep,hammingDist)
    xstep = floor(timeStep/1000*fs);
    wstep = floor(timeWindow/1000*fs);
    
    steps = floor(length(x)/xstep);
    spec = zeros(wstep,steps);
    curstep = 1;
    whamming = hamming(wstep);
     
    for i=1:steps
        if curstep+wstep-1 > length(x)
            break
        end
        window = x(curstep:curstep+wstep-1);
        if (hammingDist == 1)
            window = window .* whamming;
        end
        f = fft(window);
        spec(:,i) = f;
        curstep = curstep + xstep;
    end
end
