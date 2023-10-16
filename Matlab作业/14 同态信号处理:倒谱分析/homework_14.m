clc; clear; close all;

addpath('homework14_function/.')

audiofile = 'audio/woman_voice.wav';
[y, sr] = audioread(audiofile);

y = preprocessing(y);
s = enframing(y, 1024);

[Ceps_formant_F1,Ceps_formant_F2, Ceps_f0] = Cepstrum_analyze(s, sr);
[LPC_formant_F1, LPC_formant_F2, LPC_f0] = LPC_base_calculate(s, sr);
R_N = MSTACF(y, sr);

