%main script
disp('Starting server...');
t = tcpip('0.0.0.0', 8086, 'NetworkRole', 'server');
set(t,'Timeout',86400);
set(t,'OutputBufferSize',10000);

while 1
    fopen(t);
    disp('Server started!');
    disp('New client!');
    
    %get data
    data = strcat(fread(t, 1, 'uchar'));
    if get(t,'BytesAvailable') > 1
        data = strcat(data,fread(t, t.BytesAvailable, 'uchar')');
        data = data(2:length(data));
        try
            [w,fs] = audioread(data);
            [notes,e,bpm] = fourier(w,fs);
            sdata1 = num2str(bpm);
            sdata2 = num2str(notes);
            sdata3 = num2str(e);
            sdata = sdata1;
            sdata = strcat(sdata,';');
            sdata = strcat(sdata,sdata2);
            sdata = strcat(sdata,';');
            sdata = strcat(sdata,sdata3); 
            fwrite(t,sdata);
        catch me
        end
    end
    fclose(t);
end;
