%main script
disp('Starting server...');
t = tcpip('0.0.0.0', 8086, 'NetworkRole', 'server');
set(t,'Timeout',200000);
set(t,'OutputBufferSize',10000000);
fopen(t);
disp('Server started!');

while 1    
    %get data
    data = strcat(fread(t, 1, 'uchar'));
    if get(t,'BytesAvailable') > 1
        disp('Received data');
        
        data = strcat(data,fread(t, t.BytesAvailable, 'uchar')');
        data = data(2:length(data));

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
    end;
end;
