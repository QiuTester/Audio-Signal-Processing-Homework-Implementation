function [Y_dct, audio_dct_length] = audio_dct(y, energy_percent)
    X_dct = dct(y);
    Y_dct = X_dct(2 : end);
    [~, index] = sort(abs(Y_dct), 'descend');
    i = 1;
    while norm(Y_dct(index(1:i) ) ) / norm(Y_dct) < energy_percent*0.01
        i = i + 1;
    end
    needed = i;
    Y_dct(index(needed+1:end)) = 0;
    audio_dct_length = length(Y_dct);
end

