function signal_entropy = spectral_entropy(s, f)
    signal_entropy = [ ];
    band_width = log2(length(f));
    for i = 1 : size(s, 2)
        H = [ ];
        for k = 1 : length(f)
            H(k) = s(k, i) .* log2(s(k, i));
        end
        signal_entropy(i) = -sum(H) / band_width;
    end

end