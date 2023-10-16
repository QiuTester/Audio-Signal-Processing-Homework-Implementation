function [rate, extent] = Vibrato_analyse(baseband_freq_curve, f_sr)
    f_cent = 1200 * log2(baseband_freq_curve / 440);
    nfft = 32;
    noverlap = 8;
    f_len = nfft/2;
    freq = linspace(f_sr/nfft, f_sr/2, f_len);

    window = hanning(nfft);
    X = spectrogram(f_cent, window, noverlap, freq);
    X = abs(X);

    X_n = [ ];
    P_vmod = [ ];
    for j = 1 : size(X, 2)
        X_n(:, j) = X(:, j) ./ sum(X(:, j));
        P_vmod(j) = sum(X_n(freq>5 & freq < 20, j)) / sum(X_n(:, j));
    end
    Vibrato_frame = find(P_vmod > 0.2);

    R_n = 0;
    E_n = 0;
    for i = 1 : length(Vibrato_frame)
        R_n = R_n + (max(X_n(:, Vibrato_frame(i) ))-min(X_n(:, Vibrato_frame(i) )));
    end
    rate = length(Vibrato_frame) ./ R_n;
    
    for i = 1 : length(Vibrato_frame)
        X_k = X_n(:, Vibrato_frame) - mean(X_n(:, Vibrato_frame));
        X_diff = sign(X_k);
        num = 0;
        extent_n = 0;
        for j = 1 : length(X_diff)
            extent_n = extent_n + 1;
            if num == 2
                break
            end
            if X_diff(j) * X_diff(j+1) == -1
                num = num + 1;
            end   
        end
        E_n = E_n + extent_n;
    end
    extent = E_n ./ (2*length(Vibrato_frame));
end

