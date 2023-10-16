clc; clear; close all;

addpath('homework10_function/.')

audiopath = 'audiofile/test.wav';
[y, sr] = audioread(audiopath);
y = y(:, 1);

[pha_fft, pha_F] = phase_calculation(y, sr);
plot(pha_F, pha_fft); xlabel('Frequency/Hz');
audio_processing(y, sr)

[S, HOP, WS, NW, F] = preprocessing(y, sr);
Y_m = phase_modification(S, F, 300, 500);
y_m = signal_reverse(Y_m, NW, HOP, WS);
audiowrite("new_audio/test_new.wav", y_m, sr);
