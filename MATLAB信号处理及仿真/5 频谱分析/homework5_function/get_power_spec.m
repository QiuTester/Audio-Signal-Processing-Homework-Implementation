function [f, energy_each_frame] = get_power_spec(y, fs)
    win_length = 1024;
    hop_length = win_length / 2;
    W = hamming(win_length);
    f = 0 : fs/length(W) : fs/2;
    energy_each_frame = v_enframe(y, W, hop_length, 'Szp');
end