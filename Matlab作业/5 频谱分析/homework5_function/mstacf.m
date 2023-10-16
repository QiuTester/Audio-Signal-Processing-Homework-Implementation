function R_n = mstacf(y, sr)  % 修正短时自相关函数
    win1_length = 1024;
    win2_length = 2048;
    y_frames1 = enframe(y, win1_length, win1_length/2) ;
    y_frames2 = enframe(y, win2_length, win1_length/2, 'z');
    R_n = [ ];
    for n = 1:size(y_frames1, 1)-1
        R = [ ];
        for k = 1:win1_length
            sum = 0;
            for m = 1:win1_length
                sum = sum + y_frames1(n, m) * y_frames2(n, m+k-1);
            end
            R(k) = sum;
       end
       R = R / max(abs(R));
       [pks, locs] = findpeaks(R, NPeaks=7, MinPeakHeight=0.4, MinPeakDistance=sr/2000);
       base_peak = diff(locs);
       R_n(n) = sr / mean(base_peak);
    end
    R_n = medfilt1(R_n, 15);
end