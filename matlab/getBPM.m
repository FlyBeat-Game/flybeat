function bpm = getBPM(w,fs)
    b = tempo(w,fs);
    bpm = b(2);
end

