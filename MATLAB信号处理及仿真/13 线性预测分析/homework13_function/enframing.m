function  s = enframing(y, win_length)    
    W = hamming(win_length);
    s = v_enframe(y, W, 3*win_length/4);
end

