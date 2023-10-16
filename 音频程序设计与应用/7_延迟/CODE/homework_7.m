clc; clear; close all

addpath('function/.')

path = 'deep_piano.wav';

[y, sr] = audioread(path);
y = y(:, 1);

% [b1, a1] = CombFilter('DelayTime',0.5, 'SampleRate', sr, 'CutFrequency', 800, 'Type', 'FIR_Comb');
% [b2, a2] = CombFilter('DelayTime',0.5, 'SampleRate', sr, 'CutFrequency', 800, 'Type', 'IIR_Comb');
% [b3, a3] = CombFilter('DelayTime',0.5, 'SampleRate', sr, 'CutFrequency', 800, 'Type', 'Universal_Comb');
% [b4, a4] = CombFilter('DelayTime',0.5, 'SampleRate', sr, 'CutFrequency', 800, 'Type', 'Natural_Comb');


% [b1, a1] = ImprovedCombFilter('DelayTime',0.5, 'SampleRate',sr, 'CutFrequency',1000, 'Type','FIR_Direct');
% [b2, a2] = ImprovedCombFilter('DelayTime',0.5, 'SampleRate',sr, 'CutFrequency',1000, 'Type','FIR_Reflected');
[b3, a3] = ImprovedCombFilter('DelayTime',0.05, 'SampleRate',sr, 'CutFrequency',1000, 'Type','Universal');


% y_filtered1 = filter(b1, a1, y); 
% y_filtered2 = filter(b2, a2, y);
y_filtered3 = filter(b3, a3, y);
% y_filtered4 = filter(b4, a4, y);

% freqz(b1, a1, 512, sr); figure()
% freqz(b2, a2, 512, sr); figure()
H= freqz(b3, a3, 512, sr); figure()
H = abs(H);
% freqz(b4, a4, 512, sr);

