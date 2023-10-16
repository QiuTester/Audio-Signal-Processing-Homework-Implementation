function [y, sr] = preprocessing(audiopath)
    [y, sr] = audioread(audiopath);
    y = y(:, 1);
end

