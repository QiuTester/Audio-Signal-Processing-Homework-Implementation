function baseband_freq_curve = frequency_domain_curve(F, freq)
    baseband_freq_curve = [ ];
    F_normalize = [ ];
    for i = 1 : size(F, 2)
        F_normalize = F(:, i) / max(F(:, i));
        [~, locs] = findpeaks(F_normalize, NPeaks = 7, MinPeakHeight=0.1, MinPeakDistance=3);
        baseband_freq = round( sum(rmoutliers(diff(locs))) / length(diff(locs)) );
        baseband_freq_curve(i) = baseband_freq * freq(1);
    end
    baseband_freq_curve(isnan(baseband_freq_curve)) = [ ];
end

