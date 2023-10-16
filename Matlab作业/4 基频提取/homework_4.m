clc; clear; close all;

audiopath1 = 'piano.wav';
audiopath2 = '犬夜叉.wav';
[y1, sr1] = audioread(audiopath1);
[y2, sr2] = audioread(audiopath2);

y1 = pre_processing(y1);
y2 = pre_processing(y2);
D1_w = amdf(y1, sr1);
D2_w = amdf(y2, sr2);
R1_n = mstacf(y1, sr1);
R2_n = mstacf(y2, sr2);

figure('Name', '普通钢琴旋律');
subplot(2, 1, 1); plot(R1_n); xlabel('修正短时自相关函数');
subplot(2, 1 ,2); plot(D1_w); xlabel('短时平均幅度差函数');
figure('Name', '犬夜叉');
subplot(2, 1, 1); plot(R2_n); xlabel('修正短时自相关函数');
subplot(2, 1 ,2); plot(D2_w); xlabel('短时平均幅度差函数');


function y = pre_processing(y)
    [~, c] = size(y);
    if c > 1
        y = y(:, 1);
    end
    y = y - mean(y);
    y = y / max(y);
end

function D_w = amdf(y, sr)
    win_length = 2048;
    y_frame = enframe(y, win_length, win_length/2, 'z');
    D_w = [ ];
    for n = 1:size(y_frame, 1)-1
        D = [ ];
        x = y_frame(n, :);
        x = [x x];
        for k = 1:win_length
            sum = 0;
            for m = 1:win_length
                sum = sum + abs(x(m) - x(m+k-1));
            end
            D(k) = sum;
        end
        D_reverse = max(D) - D;
        D_reverse = D_reverse / max(D_reverse);
        [min, locs] = findpeaks(D_reverse, NPeaks=7, MinPeakHeight=0.5, MinPeakDistance=sr/2000);
        base_peak = diff(locs);
        peak = sr / mean(base_peak);
        D_w(n) = peak;
    end
    D_w = medfilt1(D_w, 15);
end

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
       [pks, locs] = findpeaks(R, NPeaks=7, MinPeakHeight=0.5, MinPeakDistance=sr/2000);
       base_peak = diff(locs);
       R_n(n) = sr / mean(base_peak);
    end
    R_n = medfilt1(R_n, 15);
end




