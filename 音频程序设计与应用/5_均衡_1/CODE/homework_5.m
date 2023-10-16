clc; clear; close all;

addpath('function/.')

[y, sr] = audioread('test_audio.wav');
y = y(:, 1);

% order = 100; 
% HighPassCut = 0.3; BandPassCut = [0.4 0.55]; BandStopCut = [0.05 0.3];
% 
% y_HP= FIR_Designer(y, sr, order, HighPassCut, 'high');
% y_BP = FIR_Designer(y, sr, order, BandPassCut, 'bandpass');
% y_BS = FIR_Designer(y, sr, order, BandStopCut, 'stop');

fc = 1500; fb = 1000;

y_order1_HP = IIR_Designer(y, sr, fc, 0, 'Order1-HighPass');
y_order2_HP = IIR_Designer(y, sr, fc, 0, 'Order2-HighPass');
y_order2_BP = IIR_Designer(y, sr, 11400, 3600, 'Order2-BandPass');
y_order2_BS = IIR_Designer(y, sr, 4200, 6000, 'Order2-BandStop');