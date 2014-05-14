function note = getNote(freq)
    musicNotes = [0,262,277,294,311,330,349,370,392,415,440,466,494,524];
    freq = fundamental(freq);
    
    note = 1;
    for i=2:length(musicNotes)-1
        a = (musicNotes(i));
        b = (musicNotes(i+1));
        if (freq < (a+b)/2)
            note = i;
            break;
        end
        note = i+1;
    end
end
