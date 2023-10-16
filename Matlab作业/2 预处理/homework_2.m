clc; clear; close all;

filename = 'female.wav';
[y, fs] = audioread(filename);
y = y - mean(y);
y = y / max(abs(y));
y = pre_emphasis(y);
y_frames = enframe(y, 1024, 512, 'z');

hamm_win = hamming(1024);
triang_win = triang(1024);
rec_win = rectwin(1024);
black_win = blackman(1024);

y_hamm = windowing(y_frames, hamm_win);
y_triang = windowing(y_frames, triang_win);
y_rec = windowing(y_frames, rec_win);
y_black = windowing(y_frames, black_win);

figure(1);
subplot(4, 1, 1); plot(hamm_win); xlabel('hamming window'); xlim([0 1024]);
subplot(4, 1, 2); plot(triang_win); xlabel('triangle window'); xlim([0 1024]); 
subplot(4, 1, 3); plot(rec_win); xlabel('rectangular window'); xlim([0 1024]);
subplot(4, 1, 4); plot(black_win); xlabel('blackman window'); xlim([0 1024]);

N = 48000;
[H_hamm1, f1, w1] = freqz(hamm_win, 1, N, "whole", fs);
[H_hamm2, f2, w2] = freqz(hamm_win, 1, "whole", fs);
[H_rec, f3] = freqz(rec_win, 1, fs);
[H_black, f4] = freqz(black_win, 1, fs);
figure(2);
subplot(2, 1, 1); plot(f1, 20*log10(abs(H_hamm1))); xlabel('hamming window1'); 
subplot(2, 1, 2); plot(f2, 20*log10(abs(H_hamm2))); xlabel('hamming window2'); 

figure(3);
subplot(5, 1, 1); plot(y_frames(1, :)); xlabel('source'); xlim([0 1024]);
subplot(5, 1, 2); plot(y_hamm(1, :)); xlabel('hamming window'); xlim([0 1024]);
subplot(5, 1, 3); plot(y_triang(1, :)); xlabel('triangle window'); xlim([0 1024]);
subplot(5, 1, 4); plot(y_rec(1, :)); xlabel('rectangular window'); xlim([0 1024]);
subplot(5, 1, 5); plot(y_black(1, :)); xlabel('blackman window'); xlim([0 1024]);

info = audioinfo(filename)
time = double(info.Duration);
sound(y, fs); pause(time);
sound(y .* hamming(length(y)),  fs); pause(time);
sound(y .* triang(length(y)),  fs); pause(time);
sound(y .* rectwin(length(y)),  fs); pause(time);
sound(y .* blackman(length(y)),  fs); 

function [y_emphasis] = pre_emphasis(y)
    y_emphasis = y;
    for i = 2:size(y, 1)
        y_emphasis(i) = y_emphasis(i) - 0.98*y_emphasis(i-1);
    end
end

function [y_windowed] = windowing(y_frames, window)
    window = window';
    for i = 1:size(y_frames, 1)
        y_windowed(i, :) = y_frames(i, :) .* window;
    end
end



