function [formant_F1, formant_F2, f0] = Cepstrum_analyze(s, sr)
    formant_F1 = [ ];
    formant_F2 = [ ];
    f0 = [ ];
    for i = 1:size(s, 1)
        y_frame = s(:, i);
        y_rceps = ifft(log(abs(fft(y_frame, 1024) ) ) );
        rceps = y_rceps(1:length(y_rceps)/2);

        [~, n] = max(rceps);
        f0(i) = sr/n;        

        cepsL = 16;
        vocal = rceps(1:cepsL);
        vr = real(fft(vocal, 1024));
        vr = vr(1:nfft/2); 
        [~, f_loc] = findpeaks(vr);
        formant_F1(i) = f_loc(1);
        formant_F2(i) = f_loc(2);     
    end

    formant_F1 = medfilt1(formant_F1, 5);
    formant_F2 = medfilt1(formant_F2, 5);
    
    figure();  
    plot(formant_F1, Color='r'); hold on;  
    plot(formant_F2, Color='b')
    legend('F1', 'F2'); title('formant curve')
    figure(); plot(f0); title('Cepstrum method')    

end

