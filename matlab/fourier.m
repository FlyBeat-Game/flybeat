function [notes,bpm] = fourier(w,fs)
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
    
    %nnotes = {'-';'Dó';'Dó#';'Ré';'Ré#';'Mi';'Fá';'Fá#';'Sol';'Sol#';'Lá';'Lá#';'Si';'Dó2'};
    %for i=1:length(notes)
    %    disp(nnotes(notes(i)));
    %end
     
end
