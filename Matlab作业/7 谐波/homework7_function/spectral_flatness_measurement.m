function signal_flatness = spectral_flatness_measurement(s, f)
    signal_flatness = [ ];
    for i = 1 : size(s, 2)
        molecular = prod(power(s(:, i), 1/length(s(:, i))));
        denominator = sum(s(:, i)) / length(s(:, i));
        signal_flatness(i) = molecular / denominator;
    end
end

