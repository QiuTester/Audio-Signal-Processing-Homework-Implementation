function [b, a] = Bandpass_filter_designer(zero, pole, sr)
    b = poly(zero);
    if pole ~= [0]
        a = poly(pole);
    else
        a = [zeros(1, length(b)-1), 1];
    end
    
    freqz(a, b, 512, sr)
    
    H = tf(a, b, 1/sr);
    figure(); pzmap(H);
end

