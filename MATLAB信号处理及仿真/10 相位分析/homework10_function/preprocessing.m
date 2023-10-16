function [S, HOP, WS, NW, F] = preprocessing(x, sr)
    NW = 1024;
    OV = 2;
    win = hamming(NW, "periodic");
    W = sqrt(win);
    HOP = NW / OV;
    [S, ~, WS] = v_enframe(x, W, 1/OV, 'fa');
    F = linspace(sr/NW, sr/2, NW/2);
end

