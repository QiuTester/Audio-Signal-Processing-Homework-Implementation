function [y, sr, f, F, freq, f_sr] = pre_processing(filepath, nfft, noverlap)
    [y, sr] = audioread(filepath);
    y = y(:, 1);

    window = hann(nfft, 'periodic');
    f = enframe(y, window, nfft-noverlap)';

    f_len = nfft/2;
    freq = linspace(sr/nfft, sr/2, f_len);
    [F, freq, ~] = spectrogram(y, window, noverlap, freq);
    F = abs(F);

    f_sr = ( (1-nfft/sr) / (noverlap/sr) ) + 1;
end

