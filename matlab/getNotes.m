function notes = getNotes(freqs)
    notes = zeros(1,length(freqs));
    for i=1:length(freqs)
        f = freqs(i);
        notes(i) = getNote(f);
    end
end
