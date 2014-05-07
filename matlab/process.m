function pnote = process(note)
    pnote = note;
    while pnote < 500
        if pnote == 0
            break;
        end
        pnote = pnote*2;
    end
    while pnote > 1075
        pnote = pnote/2;
    end
end