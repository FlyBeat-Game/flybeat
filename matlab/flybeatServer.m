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
            notes = fourier(w,fs);
            sdata = num2str(notes);
            fwrite(t, sdata);
        catch me
            disp('Invalid file.');
        end
    end
    fclose(t);
end;
