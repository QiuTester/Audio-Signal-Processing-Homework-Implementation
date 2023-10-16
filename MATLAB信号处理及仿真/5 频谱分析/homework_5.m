clc; clear; close all;
addpath("homework5_function/.");        % path only in Mac, if Windows/Linux maybe can't run correctly, please change the '/'

audiofile = './audiofile/piano.wav';
[y, fs] = audioread(audiofile);
y = y(:, 1);

[f, energy_each_frame] = get_power_spec(y, fs);

total_energy = energy_sum(energy_each_frame);         % f = 0: fs/N: fs/2 (default N is the index of 2), total_energy = energy of each frequency band (sum all frames)
                                                                                              
energy_ratio = ratio_calculate(f, total_energy);              % energy ratio (50Hz~1kHz : 1kHz~5kHz)

energy_curve = energy_curve(f, energy_each_frame);         % each frame's maximum energy frequency

fundamental_curve = mstacf(y, fs);
figure(); 
subplot(2, 1, 1); plot(fundamental_curve); title('MSTACF curve');
subplot(2, 1, 2); plot(energy_curve); title('Maximum energy frequency curve');