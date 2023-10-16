clc; clear; close all;

addpath('function/.')

% [a, b] = mirtonalcentroid('C#_minor.wav', 'Frame')
% a1 = mirgetdata(a);
% b1 = mirgetdata(b);
% b2 = mean(b1, 2);
% b1 = mirgetdata(b);
% mirhcdf(a)
% [a1, b2] = mirhcdf('C#_minor.wav')

% circle_plot(a(1), a(2), 'Fifths')
% circle_plot(a(3), a(4), 'MinorThirds')
% [a,b] = mirmode('B_major.wav', 'Best')
% mirgetdata(a)

% [k,c,s]  = mirkey('B_major.wav', 'frame')
% k = mirgetdata(k);
% s = mirgetdata(s);

wav_name = '.wav';
[TonalityWhole, ModalityWhole, KeyWhole, Correlation] = Tonality_Analyze(wav_name);
[~, a] = max(Correlation)
% [TonalityFrame, ModalityFrame, KeyFrame] = Tonality_Analyze(wav_name, 'Type','Frame', 'ClarityThreshold', 0.5);
