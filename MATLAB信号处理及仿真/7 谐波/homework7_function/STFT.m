function [s, f] = STFT(y, sr, noverlap, nfft)
    window = hann(nfft);
    f_len = nfft/2;
    f = linspace(sr/nfft, sr/2, f_len);
    [s, f, ~] = spectrogram(y, window, noverlap, f, sr);
    s = abs(s);
end

