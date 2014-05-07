function note = getNote(freq)
    musicNotes = [523.25,554.37,587.33,622.25,659.25,698.46,739.99,783.99,830.61,880.00,932.33,987.77,1046.50];
    note = 1;
    for i=1:length(musicNotes)-1
        a = (musicNotes(i));
        b = (musicNotes(i+1));
        if (freq < (a+b)/2)
            note = i;
            break;
        end
        note = i+1;
    end
end
