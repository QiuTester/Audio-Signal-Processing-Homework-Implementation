clc; clear; close all;

addpath('homework11_function/.')

audiopath = 'audiofile/Soundscape-D125.wav';
[y, sr] = preprocessing(audiopath);

zero = [0.9, -1, exp(1i*pi*500*2/sr), exp(-1i*pi*500*2/sr), exp(1i*pi*500*2/sr), exp(-1i*pi*500*2/sr), exp(1i*pi*2000*2/sr), exp(-1i*pi*2000*2/sr), exp(1i*pi*2000*2/sr), exp(-1i*pi*2000*2/sr), ...
            exp(1i*pi*8000*2/sr), exp(-1i*pi*8000*2/sr), exp(1i*pi*9500*2/sr), exp(-1i*pi*9500*2/sr), exp(1i*pi*12000*2/sr), exp(-1i*pi*12000*2/sr), exp(1i*pi*15000*2/sr), exp(-1i*pi*15000*2/sr)];
pole = [0.6*exp(1i*pi*2500*2/sr), 0.6*exp(-1i*pi*2500*2/sr), 0.55*exp(1i*pi*3500*2/sr), 0.55*exp(-1i*pi*3500*2/sr), 0.5*exp(1i*pi*5000*2/sr), 0.5*exp(-1i*pi*5000*2/sr), ...
            0.55*exp(1i*pi*6000*2/sr), 0.55*exp(-1i*pi*6000*2/sr), 0.6*exp(1i*pi*6000*2/sr), 0.6*exp(-1i*pi*6000*2/sr), 0, 0, 0, 0, 0, 0, 0, 0];
[b, a] = Bandpass_filter_designer(pole, zero, sr);

y_filted = filter(a, b, y);
y_filted = y_filted / max(abs(y_filted));
audiowrite('new_audio/zero_pole_method.wav', y_filted, sr);

y_filted1 = IIR_filter(y);
y_filted2 = FIR_filter(y);
audiowrite('new_audio/Butter_method.wav', y_filted1, sr);
audiowrite('new_audio/Window_method.wav', y_filted2, sr);