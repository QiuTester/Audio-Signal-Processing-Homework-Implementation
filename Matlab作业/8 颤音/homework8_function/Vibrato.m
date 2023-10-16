function Jitter = Vibrato(baseband_freq_curve)
    Jitter = 0;
    num = 0;
    for i = 1 : size(baseband_freq_curve, 2)-1
        freq_diff = abs(baseband_freq_curve(i) - baseband_freq_curve(i+1));
        if ~isnan(freq_diff)
            Jitter = Jitter + freq_diff;
            num = num +1;
        end
    end
    Jitter = Jitter / num;
end

