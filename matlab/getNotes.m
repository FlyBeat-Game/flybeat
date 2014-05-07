function notes = getNotes(freqs)
    length(freqs)
    notes = zeros(1,length(freqs));
    for i=1:length(freqs)
        f = process(freqs(i));
        notes(i) = getNote(f);
    end
end
