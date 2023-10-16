clc; clear()

[b, a] = iircomb(2, 0.2);
% [b, a] = iircomb(5, 0.2);
% [b, a] = iircomb(10, 0.2);
% [b, a] = iircomb(15, 0.2);

res = freqz(b, a, 512);
res = abs(res);

[audio, fs] = audioread('/Users/qiu/Desktop/audio_signal/C_major.mp3');
audio = audio(:, 1);
audio = audio(1:length(audio)/5);

tic
time1 = conv(audio, res);
toc

tic
time2 = filter(b, 1, audio);
toc
