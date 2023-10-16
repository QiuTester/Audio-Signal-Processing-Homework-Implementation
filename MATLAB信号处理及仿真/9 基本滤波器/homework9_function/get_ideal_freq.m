function  h_d = get_ideal_freq(w_p, w_st, win_length, filter_type)
    w_c = (w_p + w_st) / 2;
    h_d = [ ];
    tau = (win_length-1) / 2;
    if strcmp(filter_type, 'lowpass')
        for i = 1 : 10
            for n = 1:win_length
                if n-1 == tau
                    h_d(n + (i-1)*win_length) = w_c / pi;
                else
                    h_d(n + (i-1)*win_length) = sin(w_c * ((n-1) - tau)) / (pi * ((n-1)-tau));
                end
            end
        end

    elseif strcmp(filter_type, 'highpass')
        for i = 1 : 10
            for n = 1:win_length
                if n-1 == tau
                    h_d(n + (i-1)*win_length) = 1 - w_c / pi;
                else
                    h_d(n + (i-1)*win_length) = -sin(w_c * ((n-1) - tau)) / (pi * ((n-1)-tau));
                end
            end
        end

    end
end

