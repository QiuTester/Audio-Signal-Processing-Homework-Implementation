function signal_slope = spectral_slope(s)
    signal_slope = [ ];
    for i = 1 : size(s, 2)
        s_detrend = detrend(s(:, i));
        trend = s(:, i) - s_detrend;
        signal_slope(i) = mean(diff(trend));
    end
end

