function e = energy(w,fs,timeStep)
    wstep = floor(timeStep/1000*fs);
    steps = floor(length(w)/wstep);
    abswave = (w.^2);
    e = zeros(1,steps);
    cur = 1;
    for i=1:steps
        wave = abswave(cur:cur+wstep);
        e(i) = sum(wave);
        cur = cur + wstep;
    end
end

