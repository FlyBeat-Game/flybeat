function notes = fourier(w,fs)
    bpm = 120;
    intervalo = (60/bpm)*1000;
    r = abs(stfft(w,fs,intervalo*2));
    f = freqs(r);
    notes = getNotes(f);
end