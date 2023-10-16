function [y, sr, duration_time] = audio_signal_preprocessing(filepath)
    [y, sr] = audioread(filepath);
    y = y(:, 1);
    duration_time = double(audioinfo(filepath).Duration);
end

