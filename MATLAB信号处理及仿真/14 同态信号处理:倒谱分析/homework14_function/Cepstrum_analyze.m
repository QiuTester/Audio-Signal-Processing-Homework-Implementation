function [formant_F1, formant_F2, f0] = Cepstrum_analyze(s, sr)
    formant_F1 = [ ];
    formant_F2 = [ ];
    f0 = [ ];
    for i = 1:size(s, 1)
        y_frame = s(:, i);
        y_rceps = ifft(log(abs(fft(y_frame, 1024) ) ) );
        rceps = y_rceps(1:length(y_rceps)/2);    

        cepsL = floor(sr / 500);
        vocal = rceps(1:cepsL);
        vr = real(fft(vocal, 1024));
        vr = vr(1:length(vr)/2); 
        [~, f_loc] = findpeaks(vr);
        formant_F1(i) = f_loc(1) * sr / 1024;
        formant_F2(i) = f_loc(2) * sr / 1024;     

        [~, locs] = findpeaks(rceps(cepsL:end), 'MinPeakDistance', 140);
        n = mean(diff(locs));
        f0(i) = sr / n; 

    end

    f0 = medfilt1(f0, 5);
    formant_F1 = medfilt1(formant_F1, 5);
    formant_F2 = medfilt1(formant_F2, 5);
    
    figure();  
    plot(formant_F1, Color='r'); hold on;  
    plot(formant_F2, Color='b')
    legend('F1', 'F2'); title('Cepstrum method')
    figure(); plot(f0); title('Cepstrum method')    

end

