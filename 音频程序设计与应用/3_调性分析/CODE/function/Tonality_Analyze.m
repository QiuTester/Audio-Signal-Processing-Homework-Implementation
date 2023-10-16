function [Tonality, Modality, Key, Correlation] = Tonality_Analyze(path, varargin)

    defaultMode = 'Whole';
    expectedMode = {'Whole', 'Frame'};
    defaultClarityThreshold = 0.7;

    p = inputParser;
    validFloatPosNum = @(x) (x > 0) && (x < 1);
    addRequired(p,'path');
    addParameter(p, 'Type', defaultMode, ...
                         @(x) any(validatestring(x, expectedMode)));
    addParameter(p, 'ClarityThreshold', defaultClarityThreshold, validFloatPosNum);
    parse(p, path,varargin{:}); 

    if strcmpi(p.Results.Type, 'Whole')
        [TonalCentroid, Chromagrame] = mirtonalcentroid(path)
        [k, c, s] = mirkey(path)
 
        TonalCentroid = mirgetdata(TonalCentroid);
        Chromagrame = mirgetdata(Chromagrame);
        K = mirgetdata(k);

    elseif strcmpi(p.Results.Type, 'Frame')
        [TonalCentroid, Chromagrame] = mirtonalcentroid(path, 'Frame')
        [k, c, s] = mirkey(path, 'Frame')

        TonalCentroid = mirgetdata(TonalCentroid); TonalCentroid = mean(TonalCentroid, 2);
        Chromagrame = mirgetdata(Chromagrame); Chromagrame = mean(Chromagrame, 2);
        c = mirgetdata(c); k = mirgetdata(k); K = mode(k(c>p.Results.ClarityThreshold), 2);

    end

    Modality = mirmode(path, 'Best')
    if mirgetdata(Modality) > 0
        Modality = 'Major';
    else 
        Modality = 'Minor';
    end
    
    key = string(["C M", "C# M", "D M", "D# M", "E M", "F M", "F# M", "G M", "G# M", "A M", "A# M", "B M", ...
                         "c m", "c# m", "d m", "d# m", "e m", "f m", "f# m", "g m", "g# m", "a m", "a# m", "b m"]);
    if strcmp(Modality, 'Major')
        Key = key(K);
    elseif strcmp(Modality, 'Minor')
        Key = key(K+12);
    end

    FifthsDistance = circle_plot(TonalCentroid(1), TonalCentroid(2), 'Fifths');
    MinorThirdsDistance = circle_plot(TonalCentroid(3), TonalCentroid(4), 'MinorThirds');
    MajorThirdsDistance = circle_plot(TonalCentroid(5), TonalCentroid(6), 'MajorThirds');

    CentroidEuclidianDistance = Tone_EuclidianDistance_Calculate(FifthsDistance, MinorThirdsDistance, MajorThirdsDistance)

    Matrix = readmatrix('Weighted_Tonal_Scale_Distribution.xlsx');
    Matrix = Matrix(:, 2:end);

%     TonalityMatrix = zeros(24, 12);
%     for i = 1:24
%         TonalityMatrix(i, Matrix(i, :)) = 1;
%     end

%     Correlation = Correlation_Calculate(TonalityMatrix, CentroidEuclidianDistance);
    Correlation = Correlation_Calculate(Matrix, CentroidEuclidianDistance);

    tonal = string(["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]);
    [~, index] = max(Chromagrame);
    Tonality = tonal(index);

    mirhcdf(path)

%     keys = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
%     tonal = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"];
%     Tonality = dictionary(keys, tonal);
    
end