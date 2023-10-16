function signal_irregularity = spectral_irregularity(s, f)
    signal_irregularity = [ ];
    freq_peak = [ ];
    for i = 1 : size(s, 2)
        spec = envelope(s(:, i), 150, 'rms');
        [~, locs] = findpeaks(spec, NPeaks=7);
        freq_peak = f(locs);
        peak_diff = [ ];
        for j = 2 : length(freq_peak)
            peak_diff(j-1) = (freq_peak(j) - freq_peak(j-1)).^2;
        end
        signal_irregularity(i) = sum(peak_diff) / sum(freq_peak.^2);
    end
    signal_irregularity = signal_irregularity / max(signal_irregularity);
end

