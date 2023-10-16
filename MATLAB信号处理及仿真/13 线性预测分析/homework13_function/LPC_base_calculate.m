function [formant_F1, formant_F2, f0] = LPC_base_calculate(s, sr)
    p = sr/1000 + 3;
    formant_F1 = [ ];
    formant_F2 = [ ];
    f0 = [ ];
    for i = 1 : size(s, 1)
        [a, ~] = lpc(s(i, :), p);
        [h, f] = freqz(1, a, 1024, sr);
        mh = 20 * log10(abs(h));
        [~, loc1] = findpeaks(mh);

        f_loc = f(loc1);
        formant_F1(i) = f_loc(1);
        formant_F2(i) = f_loc(2);

        y_filted = filter(a, 1, s(i, :));
        fft_y = fft(y_filted, 1024);
        fft_mag = abs(fft_y(2:512));
        fft_mag = fft_mag / max(fft_mag);
        [~, loc2] = findpeaks(fft_mag, 'MinPeakHeight', 0.1);
        f0(i) = loc2(1) * sr / 1024;
    end

    f0 = medfilt1(f0, 5);
    formant_F1 = medfilt1(formant_F1, 5);
    formant_F2 = medfilt1(formant_F2, 5);
    
    figure();
    plot(formant_F1, Color='r'); hold on; 
    plot(formant_F2, Color='b')
    legend('F1', 'F2'); title('formant curve')
    figure(); plot(f0); title('LPC method')
    
end

