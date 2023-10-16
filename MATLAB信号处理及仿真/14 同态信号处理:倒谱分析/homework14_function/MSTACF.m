function R_n = MSTACF(y, sr)
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
       [~, locs] = findpeaks(R, NPeaks=7, MinPeakDistance=sr/350);
       base_peak = diff(locs);
       R_n(n) = sr / mean(base_peak);
    end
    R_n = medfilt1(R_n, 15);

    figure();
    plot(R_n); title('MSTACF method')
end

