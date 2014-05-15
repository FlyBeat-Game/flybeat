function [notes,e,bpm] = fourier(w,fs)
    if (size(w,2) > 1)
        fusao = (w(:,1)+w(:,2))/2;
        w = fusao;
    end

    bpm = round(getBPM(w,fs));
    
    intervalo = (60/bpm)*1000;
    r = abs(stfft(w,fs,intervalo,intervalo,0));
    wstep = floor(intervalo/1000*fs);
    [f,amps] = getFreqs(r,fs,wstep,0);
    notes = getNotes(f);
    
    we = energy(w,fs,intervalo);
    e = zeros(1,length(we));
    m = max(we)-1;
    for i=1:length(we)
        e(i) = round(we(i) * 14 / m);
    end
    
    %nnotes = {'-';'Dó';'Dó#';'Ré';'Ré#';'Mi';'Fá';'Fá#';'Sol';'Sol#';'Lá';'Lá#';'Si';'Dó2'};
    %for i=1:length(notes)
    %    disp(nnotes(notes(i)));
    %end
     
end
