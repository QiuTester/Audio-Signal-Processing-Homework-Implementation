function  Y_m = phase_modification(S, f, freq_low, freq_high)
    for t = 1 : size(S, 1)
        fft_data = S(t, :);
        f0 = f>freq_low & f<freq_high;
        temp = fft_data(f0);
        theta = angle(temp) + rand(1) * pi;
        fft_data(f0) = abs(temp) .* exp(1i*theta);
        S(t, :) = fft_data;
    end
    Y_m = S;
end

