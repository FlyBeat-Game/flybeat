function spec = stfft(x,fs,step)
    mlen = length(x)/fs;
    steps = (mlen*1000)/step;
    xstep = length(x)/steps;
    spec = zeros(xstep,steps);
    curstep = 1;
    for i=1:steps
        spec(:,i) = fft(x(curstep:curstep+floor(xstep)-1));
        curstep = curstep + xstep;
    end
end