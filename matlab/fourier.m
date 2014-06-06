function [notes,e,bpm,x] = fourier(w,fs)
    if (size(w,2) > 1)
        fusao = (w(:,1)+w(:,2))/2;
        w = fusao;
    end
    
    bpm = round(getBPM(w,fs));
    if (bpm > 250)
        bpm = bpm/2;
    end
    
    intervalo = (60/bpm)*1000;
    
    r = abs(stfft(w,fs,intervalo,intervalo,0));
    
    wstep = floor(intervalo/1000*fs);
    [f,amps] = getFreqs(r,fs,wstep,0);
    
    musicNotes = [0,262,277,294,311,330,349,370,392,415,440,466,494,524];
    for i=1:length(f)
        ind = getNote(f(i));
        f(i) = musicNotes(ind);
    end
    x = freqsToSignal(f,amps,wstep,fs);
    
    notes = getNotes(f);
    for i=1:length(notes)
        notes(i) = notes(i)-1;
    end

    we = energy(w,fs,intervalo);
    e = zeros(1,length(we));
    m = max(we)-1;
    for i=1:length(we)
        e(i) = (round(we(i) * 100 / m));
    end
    
    for i=1:length(notes)
        if (e(i) < 1)
            notes(i) = 0;
        end
    end
    %nnotes = {'-';'Dó';'Dó#';'Ré';'Ré#';'Mi';'Fá';'Fá#';'Sol';'Sol#';'Lá';'Lá#';'Si';'Dó2'};
    %for i=1:length(notes)
    %    disp(nnotes(notes(i)));
    %end
     
end
