function f0 = f0_extractor(path, varargin)

    defaultMethod = 'AutoCorr';
    expectedMethod = {'AutoCorr','CepsTrum'};
    defaultMinValue = 0.0002;
    defaultMaxValue = 0.05;
    defaultCompresKValue = 0.67;
    defaultIfEnhanced = [];
    expectedIfEnhanced = {'Enhanced'};
    defaultIfComplex = [];
    expectedIfComplex = {'Complex'};

    p = inputParser;
    validScalarPosNum = @(x) isscalar(x) && (x >= 0);
    addRequired(p,'path');
    addParameter(p, 'method', defaultMethod, ...
                @(x) any(validatestring(x,expectedMethod)));
    addParameter(p, 'MinValue', defaultMinValue, validScalarPosNum);
    addParameter(p, 'MaxValue', defaultMaxValue, validScalarPosNum);
    addParameter(p, 'CompresKValue', defaultCompresKValue, validScalarPosNum);
    addParameter(p, 'IfEnhanced', defaultIfEnhanced, ...
                @(x) any(validatestring(x,expectedIfEnhanced)));
    addParameter(p, 'IfComplex', defaultIfComplex, ...
                @(x) any(validatestring(x,expectedIfComplex)));
    parse(p,path,varargin{:});
    
if strcmpi(p.Results.method, 'AutoCorr')
    
    if p.Results.IfEnhanced
        c = mirautocor(path, 'Freq', 'Frame',0.1, 'Min',p.Results.MinValue, ...
            'Max',p.Results.MaxValue, 'Compres',p.Results.CompresKValue,...
            'Enhanced');
    else
        c = mirautocor(path, 'Freq', 'Frame',0.1, 'Min',p.Results.MinValue, ...
            'Max',p.Results.MaxValue, 'Compres',p.Results.CompresKValue);
    end
    
    peak_c = mirpeaks(c, 'Total', 1);
    f0 = medfilt1(mirgetdata(peak_c), 20);
    
elseif strcmpi(p.Results.method, 'CepsTrum')
    
    if p.Results.IfComplex
        c = mircepstrum(path, 'Frame', 'Freq', 'Min',p.Results.MinValue, 'Max',p.Results.MaxValue, ...
                        'Complex');
    else
        c = mirautocor(path, 'Frame', 'Freq', 'Min',p.Results.MinValue, 'Max',p.Results.MaxValue);
    end
    
    peak_c = mirpeaks(c, 'Total', 1);
    f0 = medfilt1(mirgetdata(peak_c), 15);

end