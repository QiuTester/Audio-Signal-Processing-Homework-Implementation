clc; clear; close all;

addpath('homework8_function/.')

audiopath1 = 'audiofile/normal.wav';
audiopath2 = 'audiofile/trill.wav';

nfft = 1024;
noverlap = nfft / 2;
[y_normal, sr1, f_normal, F_normal, freq_normal, f_sr_normal] = pre_processing(audiopath1, nfft, noverlap);
[y_trill, sr2, f_trill, F_trill, freq_trill, f_sr_trill] = pre_processing(audiopath2, nfft, noverlap);

time_amp_curve_norm = time_domain_curve(f_normal);
time_amp_curve_trill = time_domain_curve(f_trill);
figure();
subplot(2, 1, 1); plot(time_amp_curve_norm); title('Normal');
subplot(2, 1, 2); plot(time_amp_curve_trill); title('Trill');

baseband_freq_curve_norm = frequency_domain_curve(F_normal, freq_normal);
baseband_freq_curve_trill = frequency_domain_curve(F_trill, freq_trill);
figure();
subplot(2, 1, 1); plot(baseband_freq_curve_norm); title('Normal');
subplot(2, 1, 2); plot(baseband_freq_curve_trill); title('Trill');

[Shim_norm, ShdB_norm] = Tremolo(time_amp_curve_norm);
[Shim_trill, ShdB_trill] = Tremolo(time_amp_curve_trill);

Jitter_norm = Vibrato(baseband_freq_curve_norm);
Jitter_trill = Vibrato(baseband_freq_curve_trill);

[rate, extent] = Vibrato_analyse(baseband_freq_curve_trill, f_sr_trill);

