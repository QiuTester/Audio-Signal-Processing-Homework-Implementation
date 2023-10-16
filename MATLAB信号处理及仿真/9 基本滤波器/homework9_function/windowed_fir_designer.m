function h = windowed_fir_designer(h_d, Kaiser_win, win_length)
    for n = 1 : win_length
        h(n) = h_d(n) * Kaiser_win(n);
    end
end

