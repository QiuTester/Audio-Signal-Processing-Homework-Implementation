clc; clear; close all;


filename = '07-添亭序_01.wav';
[y, sr] = audioread(filename);
y_highsample = resample(y, 96000, sr);
audiowrite('96000_resample.wav', y_highsample, 96000);
y_lowsample = resample(y, 24000, sr);
audiowrite('24000_resample.wav', y_lowsample, 24000);
y_2000sample = resample(y, 2000, sr);
audiowrite('2000_resample.wav', y_2000sample, 2000);

info = audioinfo(filename)
time = double(info.Duration)

sound(y, sr)
pause(info.Duration)
sound(y_highsample, 96000)
pause(info.Duration)
sound(y_lowsample, 24000)

[f, Y] = spectrum(y, time, sr);
[f_highersample, Y_highersample] = spectrum(y_highsample, time, 96000);
[f_lowersample, Y_lowersample] = spectrum(y_lowsample, time, 24000);

figure(1);
subplot(4, 1, 1); plot(y); xlabel('原始信号 48kHz sampling')
subplot(4, 1, 2); plot(y_highsample); xlabel('96kHz sampling') 
subplot(4, 1, 3); plot(y_lowsample); xlabel('24kHz sampling')
subplot(4, 1, 4); plot(y_2000sample); xlabel('2kHz sampling')

figure(2);
subplot(3, 1, 1); plot(f, Y); xlabel('原始信号 48kHz sampling'); xlim([0 48000])
subplot(3, 1, 2); plot(f_highersample, Y_highersample); xlabel('96kHz sampling'); xlim([0 48000])
subplot(3, 1, 3); plot(f_lowersample, Y_lowersample); xlabel('24kHz sampling'); xlim([0 48000])

 
function [f, P1] = spectrum(y, time, sr)
    Y = fft(y);
    L = time * sr;
    P2 = abs(Y / L);
    P1 = P2(1 : L/2+1);
    P1(2:end-1) = 2 * P1(2 : end-1);
    f = sr * (0:(L/2)) / L;
end


