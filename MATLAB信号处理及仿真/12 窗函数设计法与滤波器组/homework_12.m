clc; clear; close all;

addpath('homework12_function/.');

audiopath = 'audio/piano.wav';
[y, sr] = audioread(audiopath);
y = y(:, 1);
[Freqz, Amp, freq_response, y_freq, h] = middle_ear_transfer_function(1024);
figure(); plot(h); title('Middle Ear Transfer Function - Impulse Response');
y_filter = conv(y, h', 'same');
audiowrite('new_audio/piano_pre.wav', y, sr);
audiowrite('new_audio/piano_back.wav', y_filter, sr);

[F0, Y_bank_filted, freq] = erb_filter_bank(y, sr, 2048);
Bank_freq_plot(freq, Y_bank_filted, 40)
