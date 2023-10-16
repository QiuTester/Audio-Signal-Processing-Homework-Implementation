function Envelope = envelope_extractor(path, varargin)

    defaultMethod = 'Filter';
    expectedMethod = {'Filter','Spectro'};
    defaultFilterType = 'IIR';
    expectedFilterType = {'IIR','Butter','HalfHann'};
    defaultCutOffFreq = 30;
    defaultDownSamRate = 16;
    defaultFrameLength = .1;
    defaultBandType = 'Freq';
    expectedBandType = {'Freq','Mel','Bark','Cents'};
    defaultOperation = [];
    exceptedOperation = {'Complex','Terhardt', 'TimeSmooth'};

    p = inputParser;
    validScalarPosNum = @(x) isscalar(x) && (x > 0);
    addRequired(p,'path');
    addParameter(p, 'method', defaultMethod, ...
                 @(x) any(validatestring(x,expectedMethod)));
    addParameter(p, 'FilterType', defaultFilterType, ...
                 @(x) any(validatestring(x,expectedFilterType)));
    addParameter(p, 'CutOffFreq', defaultCutOffFreq, validScalarPosNum);
    addParameter(p, 'DownSamRate', defaultDownSamRate, validScalarPosNum);
    addParameter(p, 'FrameLength', defaultFrameLength, validScalarPosNum);
    addParameter(p, 'BandType', defaultBandType, ...
                 @(x) any(validatestring(x,expectedBandType)));
    addParameter(p, 'Operation', defaultOperation, ...
                 @(x) any(validatestring(x,exceptedOperation)));
    parse(p,path,varargin{:});

if strcmpi(p.Results.method, 'Filter')
     Env = mirenvelope(path, 'Filter', 'FilterType',p.Results.FilterType, ...
       'CutOff',p.Results.CutOffFreq, 'PostDecim', p.Results.DownSamRate);
        
else
    if p.Results.Operation
         Env = mirenvelope(path, 'Spectro', 'Frame',p.Results.FrameLength, ...
                          p.Results.BandType, p.Results.Operation);   
    else
         Env = mirenvelope(path, 'Spectro', 'Frame',p.Results.FrameLength, ...
                          p.Results.BandType);
    end
    
end  

Envelope = mirgetdata(mirsum(Env));