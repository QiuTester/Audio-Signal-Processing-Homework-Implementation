function  bpm = Rhythm_Extractor(path, varargin)

    defaultBandsType = 'Bark';
    expectedBandsType = {'Bark','Mel'};
    defaultFreqRange = 10;
    defaultFreqResolution = 0.01;
    defaultIfSum = 'false';
    expectedIfSum = {'false','true'};
    defaultInstruRange = 5;
    defaultThreshold = 1;
    defaultBeatSpec = 'false';
    expectedBeatSpec = {'false','true'};

    p = inputParser;
    validScalarPosNum = @(x) isscalar(x) && (x > 0);
    addRequired(p,'path');
    addParameter(p, 'BandsType', defaultBandsType, ...
                         @(x) any(validatestring(x,expectedBandsType)));
    addParameter(p, 'FreqRange', defaultFreqRange, validScalarPosNum);
    addParameter(p, 'FreqResolution', defaultFreqResolution, validScalarPosNum);
    addParameter(p, 'IfSum', defaultIfSum, ...
                         @(x) any(validatestring(x,expectedIfSum)));
    addParameter(p, 'InstrumentRange', defaultInstruRange, validScalarPosNum);
    addParameter(p, 'Threshold', defaultThreshold, validScalarPosNum);
    addParameter(p, 'BeatSpec', defaultBeatSpec, ...
                         @(x) any(validatestring(x,expectedBeatSpec)));
    parse(p,path,varargin{:}); 

    if strcmpi(p.Results.BeatSpec, 'false')
        if strcmpi(p.Results.IfSum, 'true')
            TypicalRhythmPattern = mirfluctuation(path, p.Results.BandsType, 'Max',p.Results.FreqRange, 'MinRes',p.Results.FreqResolution, 'Summary');
            peaks = mirpeaks(TypicalRhythmPattern, 'Threshold',p.Results.Threshold, 'Contrast',0.2, 'Order','Abscissa');
            RhythmPattern = mirgetdata(peaks); bpm = round(60*RhythmPattern(1));

        elseif strcmpi(p.Results.IfSum, 'false')
            RhythmPattern = mirfluctuation(path, p.Results.BandsType, 'Max',p.Results.FreqRange, 'MinRes',p.Results.FreqResolution);
            RhythmPattern = mirgetdata(RhythmPattern);
            Y(1:size(RhythmPattern,1), 1:size(RhythmPattern,3)) = RhythmPattern(:, 1, :);
            Y = Y(2:end, :); Z = Y(:, 1:p.Results.InstrumentRange); Fluc = sum(Z, 2);
            [~, peaks] = findpeaks(Fluc, 'MinPeakDistance',60, 'Threshold',p.Results.Threshold);
            bpm = round(60*peaks(1)*10/length(Fluc));
    
        end

    elseif strcmpi(p.Results.BeatSpec, 'true')
        beat = mirbeatspectrum(path);
        peaks = mirpeaks(beat, 'Threshold',p.Results.Threshold, 'Contrast',0.2, 'Order','Abscissa'); z = mirgetdata(peaks);
        bpm = 60 / z(2);
        
    end

end