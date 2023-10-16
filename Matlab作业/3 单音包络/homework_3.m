clc; clear; close all;
env_solving( 'piano.wav', 440);
env_solving( 'tuba.wav', 55);
env_solving( 'synth.wav', 1760);

function env_solving(audiopath, f0)
    [y, fs] = audioread(audiopath);
    info = audioinfo(audiopath);
    audio_name = strsplit(info.Filename, '/');
    audio_name = char(audio_name(end));
    audio_name = strsplit(audio_name, '.');
    name = char(audio_name(1));

    y = preprocessing(y);
    [yupper_hilbert, yupper_rms, yupper_peak] = get_envelope(y);
    [y_sin, env_hilbert, env_rms, env_peak] = envelope_processing(y, fs, f0, yupper_hilbert, yupper_rms, yupper_peak);
    plot_image(y, name, yupper_hilbert, yupper_rms, yupper_peak, env_hilbert, env_rms, env_peak);
    sound_all(y, y_sin, env_hilbert, env_rms, env_peak, double(info.Duration), fs);
    audiowrite([name, '_hilbert.wav'], env_hilbert, fs) ;
    audiowrite([name, '_rms.wav'], env_rms, fs) ;
    audiowrite([name, '_peak.wav'], env_peak, fs) ;

    function y = preprocessing(y)
    [~, c] = size(y);
    if c > 1
        y = y(:, 1);
    end
    y = y - mean(y) ;
    y = y / max(abs(y)) ;
    end
    
    function [yupper_hilbert, yupper_rms, yupper_peak] = get_envelope(y)
    fl = 200; wl = 200; np = 200;
    [yupper_hilbert, ~] = envelope(y, fl, 'analytic');
    [yupper_rms, ~] = envelope(y, wl, 'rms');
    [yupper_peak, ~] = envelope(y, np, 'peak');
    yupper_peak(yupper_peak<0) = 0;
    yupper_hilbert = yupper_hilbert / max(abs(yupper_hilbert));
    yupper_rms = yupper_rms / max(abs(yupper_rms));
    yupper_peak = yupper_peak / max(abs(yupper_peak));
    end
    
    function [y_sin, env_hilbert, env_rms, env_peak] = envelope_processing(y, fs, f0, yupper_hilbert, yupper_rms, yupper_peak)
    [f1, f2, f3, f4, f5, f6] = deal(f0*2, f0*3, f0*4, f0*5, f0*6, f0*7);
    t = 0 : 1/fs : (length(y)-1)/fs;
    y_sin = (1/7)*sin(2*pi*f0 * t) + (1/7)*sin(2*pi*f1 * t) + (1/7)*sin(2*pi*f2 * t) + (1/7)*sin(2*pi*f3 * t) + ...
        (1/7)*sin(2*pi*f4 * t) + (1/7)*sin(2*pi*f5 * t) + (1/7)*sin(2*pi*f6 * t);
    env_hilbert = y_sin .* yupper_hilbert' ;
    env_rms = y_sin .* yupper_rms' ;
    env_peak = y_sin .* yupper_peak' ;
    env_hilbert = env_hilbert / max(env_hilbert) ;
    env_rms = env_rms / max(env_rms) ;
    env_peak = env_peak / max(env_peak);
    end

    function plot_image(y, name, yupper_hilbert, yupper_rms, yupper_peak, env_hilbert, env_rms, env_peak)
    figure('Name', name);
    subplot(3, 2, 1); plot(y); hold on; plot(yupper_hilbert, 'r'); ylim([0 1]); xlabel('Hilbert滤波器包络法');
    subplot(3, 2, 2); plot(env_hilbert); ylim([0 1]); xlabel('Hilbert滤波器包络法处理后波形');

    subplot(3, 2, 3); plot(y); hold on; plot(yupper_rms, 'g'); ylim([0 1]); xlabel('RMS包络法');
    subplot(3, 2, 4); plot(env_rms); ylim([0 1]); xlabel('RMS包络法处理后波形');

    subplot(3, 2, 5); plot(y); hold on; plot(yupper_peak, 'b'); ylim([0 1]); xlabel('峰值包络法');
    subplot(3, 2, 6); plot(env_peak); ylim([0 1]); xlabel('峰值包络法处理后波形');
    end
    
    function sound_all(y, y_sin, env_hilbert, env_rms, env_peak, time, fs)
    sound(y, fs); pause(time);
    sound(y_sin, fs); pause(time);
    sound(env_hilbert, fs); pause(time);
    sound(env_rms, fs); pause(time);
    sound(env_peak, fs); pause(time);
    end

end