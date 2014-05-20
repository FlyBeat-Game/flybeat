%main script
disp('Starting server...');
t = tcpip('0.0.0.0', 8086, 'NetworkRole', 'server');
set(t,'Timeout',5);
set(t,'OutputBufferSize',10000000);
fopen(t);
disp('Server started!');
disp('New client!');

while 1    
    %get data
    data = strcat(fread(t, 1, 'uchar'));
    if get(t,'BytesAvailable') > 1
        data = strcat(data,fread(t, t.BytesAvailable, 'uchar')');
        data = data(2:length(data));
        try
            [w,fs] = audioread(data);
            [notes,e,bpm] = fourier(w,fs);
            sdata1 = num2str(bpm);
            sdata2 = commas(notes);
            sdata3 = commas(e);
            sdata = sdata1;
            sdata = strcat(sdata,';');
            sdata = strcat(sdata,sdata2);
            sdata = strcat(sdata,';');
            sdata = strcat(sdata,sdata3);
            sdata = strcat(sdata,'e');
            fwrite(t,sdata);
            sdata
        catch me
        end
    end
end;
