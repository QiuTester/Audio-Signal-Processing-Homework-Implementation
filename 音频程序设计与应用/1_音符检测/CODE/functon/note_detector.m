function [peak_loc, valley_loc] = note_detector(path, varargin)
    
    defaultMethod = 'Valley';
    expectedMethod = {'Valley','Segment'};
    defaultChannelNum = 7;
    defaultSpecOverlap = 1;
    defaultPredefinedFilter = [];
    expectedPredefinedFilter = {'Mel','Bark','Scheirer','Klapuri'};
    defaultComputeWay = 'Pitch';
    expectedComputeWay = {'Envelope','SpectralFlux','Pitch','Novelty'};
    defaultMinValue = 30;
    defaultMaxValue = 1000;
    defaultKernelSize = 32;
    defaultPeakContrast = .1;
    defaultPeakThreshold = .1;
    defaultSegMethod = 'Novelty';
    expectedSegMethod = {'Novelty','HCDF','RMS'};
    
    p = inputParser;
    validScalarPosNum = @(x) isscalar(x) && (x >= 0);
    validInteger = @(x) (x >= 1) && (x <= 3);
    addRequired(p,'path');
    addParameter(p, 'method', defaultMethod, ...
                @(x) any(validatestring(x,expectedMethod)));
    addParameter(p, 'ChannelNum', defaultChannelNum, validScalarPosNum);
    addParameter(p, 'SpecOverlap', defaultSpecOverlap, validInteger);
    addParameter(p, 'PredefinedFilter', defaultPredefinedFilter, ...
                @(x) any(validatestring(x,expectedPredefinedFilter)));
    addParameter(p, 'ComputeWay', defaultComputeWay, ...
                @(x) any(validatestring(x,expectedComputeWay)));
    addParameter(p, 'MinValue', defaultMinValue, validScalarPosNum);
    addParameter(p, 'MaxValue', defaultMaxValue, validScalarPosNum);
    addParameter(p, 'KernelSize', defaultKernelSize, validScalarPosNum);
    addParameter(p, 'PeakContrast', defaultPeakContrast, validScalarPosNum);
    addParameter(p, 'PeakThreshold', defaultPeakThreshold, validScalarPosNum);
    addParameter(p, 'SegMethod', defaultSegMethod, ...
                @(x) any(validatestring(x,expectedSegMethod)));
    parse(p,path,varargin{:});    

if p.Results.PredefinedFilter
    f = mirfilterbank(path, 'Channels', 1:p.Results.ChannelNum, ...
                  'Hop',p.Results.SpecOverlap, p.Results.PredefinedFilter);
else
    f = mirfilterbank(path, 'Channels', 1:p.Results.ChannelNum, ...
                  'Hop',p.Results.SpecOverlap);
end

wave = mirsum(f);
peak = mirevents(wave, p.Results.ComputeWay, ...
                 'Min',p.Results.MinValue, 'Max',p.Results.MaxValue, ...
                 'KernelSize',p.Results.KernelSize, 'Contrast',p.Results.PeakContrast, ...
                 'Threshold',p.Results.PeakThreshold);
peak_loc = mirgetdata(peak);

if strcmpi(p.Results.method, 'Valley')
    valley = mirevents(wave, 'Pitch', 'Detect','Valleys', ...
                 'Contrast',0.1, 'Threshold', 0.1);
    valley_loc = mirgetdata(valley);
    [y, sr] = audioread(path);
  
    zero_y = zeros(length(peak_loc), 1);
    peak_loc = floor(sr * peak_loc);
    valley_loc = floor(sr * valley_loc);
    figure();
    plot(y);
    xline(peak_loc, 'Color','r');
    xline(valley_loc, 'Color','b')

elseif strcmpi(p.Results.method, 'Segment')
    mirsegment(path, peak, p.Results.SegMethod)            
end