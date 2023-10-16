function [win, M] = get_Kaiser_window(w_p, w_st, delta)
    win = [ ];
    w_c = (w_p + w_st) / 2;
    Delta_w = w_st - w_p;
    A = -20 * log10(delta);

    if A > 50
        beta = 0.1102 * (A - 8.7);
    elseif A < 21
        beta = 0;
    else
        beta = 0.5842 * (A-21)^0.4 + 0.07886 * (A-21);
    end
    M = ceil((A-8) / (2.285*Delta_w));
    alpha = M / 2;

    win = kaiser(M, beta);
end

