clc; clear; close all;

addpath("homework7_function/.")

nfft = 1024;
noverlop = nfft / 2;
filepath = 'audiofile/tuba.wav';
[y, sr, time_duration] = audio_signal_preprocessing(filepath);
[s, f] = STFT(y, sr, noverlop, nfft);
[Y_spec, ff] = FFT_monophoic(y, sr);

signal_slope = spectral_slope(s);             
signal_entropy = spectral_entropy(s, f);
signal_flatness = spectral_flatness_measurement(s, f);
signal_irregularity = spectral_irregularity(s, f);
signal_flux = spectral_flux(s);
signal_roll_off = spectral_roll_off(s, 0.95, f);
signal_contrast = spectral_contrast(s, f);
[signal_ratio, monophonic_ratio]  = spectral_energy_ratio(Y_spec, s);
[signal_TS, monophonic_TS] = TriStimulus(Y_spec, s);
signal_inharmo = Inharmonicity(s, f, 120);

feature_plot(signal_slope, signal_entropy, signal_flatness, signal_irregularity, signal_flux, signal_roll_off, signal_contrast, ...
    signal_ratio, signal_TS, signal_inharmo)

add_harmonicty(y, sr, 230, signal_ratio, signal_TS);