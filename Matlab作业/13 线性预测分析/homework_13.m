clc; clear; close all;

addpath('homework13_function/.');

audiopath = '/Users/qiu/Desktop/audio_signal/vol.wav';
[y, sr] = audioread(audiopath);

y = preprocessing(y, 'voice');
s = enframing(y, 1024);

[formant_F1, formant_F2, f0] = LPC_base_calculate(s, sr);
R_N = MSTACF(y, sr);
