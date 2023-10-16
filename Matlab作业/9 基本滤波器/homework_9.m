clc; clear; close all;

addpath('homework9_function/.')

audiofile = 'audio/jazz.wav';
[y, sr] = audioread(audiofile);
y = y(:, 1);

f_low = 1000;
f_high = 2000;
H_lowpass = fir1(60, f_low/sr, 'low');
H_highpass = fir1(60, f_high/sr, "high");
H_bandpass = fir1(60, [0.1 0.2], 'bandpass');
H_bandstop = fir1(60, [0.1 0.2], 'stop');
signal_lowpass = fftfilt(H_lowpass, y);
signal_highpass = fftfilt(H_highpass, y);
signal_bandpass = fftfilt(H_bandpass, y);
signal_bandstop = fftfilt(H_bandstop, y);
audiowrite('new_audio/audio_lowpass.wav', signal_lowpass, sr)
audiowrite('new_audio/audio_highpass.wav', signal_highpass, sr)
audiowrite('new_audio/audio_bandpass.wav', signal_bandpass, sr)
audiowrite('new_audio/audio_bandstop.wav', signal_bandstop, sr)
figure(); freqz(H_lowpass)
figure(); freqz(H_highpass)
figure(); freqz(H_bandpass)
figure(); freqz(H_bandstop)

w_p = 0.4 * pi;
w_st = 0.6 * pi;
delta = 0.001;
[Kaiser_win, win_length] = get_Kaiser_window(w_p, w_st, delta);
h_d = get_ideal_freq(w_p, w_st, win_length, 'highpass');
h = windowed_fir_designer(h_d, Kaiser_win, win_length);
figure()
subplot(2, 1, 1); plot(Kaiser_win); title('Kaiser Window')
subplot(2, 1, 2); plot(h_d); title('Ideal Impulse Response')
figure('Name', 'Impulse Response'); impz(h)
figure('Name', 'Frequency Response'); freqz(h)
