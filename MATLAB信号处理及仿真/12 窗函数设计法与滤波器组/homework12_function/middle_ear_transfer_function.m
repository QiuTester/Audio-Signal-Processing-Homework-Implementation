function [Freqz, Amp, freq_response, y_freq, h] = middle_ear_transfer_function(L)
    Freqz = [20, 25, 31.5, 40, 50, 63, 80, 100, 125, 160, 200, 250, 315, 400, 500, 630, 750, 800, 1000, 1250, 1500, 1600, 2000, 2500, ...
                  3000, 3150, 4000, 5000, 6000, 6300, 8000, 9000, 10000, 11200, 12500, 14000, 15000, 16000, 20000];
    Amp = [-39.2, -31.4, -25.4, -20.9, -18, -16.1, -14.2, -12.5, -11.1, -9.7, -8.4, -7.2, -6.1, -4.7, -3.7, -3, -2.7, -2.6, -2.6, -2.7, ...
                 -3.7, -4.6, -8.5, -10.8, -7.3, -6.7, -5.7, -5.7, -7.6, -8.4, -11.3, -10.6, -9.9, -11.9, -13.9, -16, -17.3, -17.8, -20];
    y_freq = linspace(20, 20000, L);
    
    freq_response = interp1(Freqz, Amp, y_freq);
    freq_response(isnan(freq_response)) = -40;
    subplot(2, 1, 1); plot(Freqz, Amp); title('Middle Ear Transfer Function - Amplitude Frequency Response - Before Interped')
    subplot(2, 1, 2); plot(freq_response);title('Middle Ear Transfer Function - Amplitude Frequency Response - After Interped')
    freq_response = db2mag(freq_response);

    h = ifft(freq_response);
    h = h .* kaiser(L, 0.5)';
    h = h(1 : length(h)/2);
end