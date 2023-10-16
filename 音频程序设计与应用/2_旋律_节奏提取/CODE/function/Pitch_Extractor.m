function [p, ac] = Pitch_Extractor(path, varargin)
    
    defaultIfMono = false;
    expectedIfMono = {'false','true'};
    defaultFilterBank = '2Channels';
    expectedFilterBank = {'2Channels','Gammatone','NoFilterbank'};
    defaultMinValue = 50;
    defaultMaxValue = 2400;
    defaultThreshold = 0.2;
    defaultContrast = 0.1;
    defaultMedFilterLength = 0.1;
    defaultSegment = 'Lartillot';
    expectedSegment = {'Lartillot','Nymoen'};

    p = inputParser;
    validScalarPosNum = @(x) isscalar(x) && (x > 0);
    addRequired(p,'path');
    addParameter(p, 'IfMono', defaultIfMono, ...
                         @(x) any(validatestring(x,expectedIfMono)));
    addParameter(p, 'FilterBank', defaultFilterBank, ...
                         @(x) any(validatestring(x,expectedFilterBank)));
    addParameter(p, 'MinValue', defaultMinValue, validScalarPosNum);
    addParameter(p, 'MaxValue', defaultMaxValue, validScalarPosNum);
    addParameter(p, 'Threshold', defaultThreshold, validScalarPosNum);
    addParameter(p, 'Contrast', defaultContrast, validScalarPosNum);
    addParameter(p, 'MedianLength', defaultMedFilterLength, validScalarPosNum);
    addParameter(p, 'Segment', defaultSegment, ...
                          @(x) any(validatestring(x,expectedSegment)));
    parse(p,path,varargin{:}); 

    if strcmpi(p.Results.IfMono, 'true')
        [p, ac] = mirpitch(path, 'Frame', 'Mono', p.Results.FilterBank, 'Min',p.Results.MinValue, 'Max',p.Results.MaxValue, 'Threshold',p.Results.Threshold, ...
                               'Contrast',p.Results.Contrast, 'Median',p.Results.MedianLength, 'Segment', p.Results.Segment)

    elseif strcmpi(p.Results.IfMono, 'false')
        [p, ac] = mirpitch(path, 'Frame', p.Results.FilterBank, 'Min',p.Results.MinValue, 'Max',p.Results.MaxValue, 'Threshold',p.Results.Threshold, ...
                               'Contrast',p.Results.Contrast)
    end

end