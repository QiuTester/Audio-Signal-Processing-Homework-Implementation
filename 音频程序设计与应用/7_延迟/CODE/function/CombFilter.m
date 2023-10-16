function [b, a] = CombFilter(varargin)

    defaultIfDelayTime = 2;
    defaultFeedforwardGain = 0.4;
    defaultFeedbackGain = 0.4;
    defaultDirectGain = 0.6;
    defaultSampleRate = 48000;
    defaultLowpassCutFreq = 2000;
    defaultFitlterType = 'FIR_Comb';
    expectedFilterType = {'FIR_Comb', 'IIR_Comb', 'Universal_Comb', 'Natural_Comb'};

    p = inputParser;
    validScalarPosNum = @(x) isscalar(x) && (x > 0);
    addParameter(p, 'DelayTime', defaultIfDelayTime, validScalarPosNum);
    addParameter(p, 'FeedforwardGain', defaultFeedforwardGain, validScalarPosNum);
    addParameter(p, 'FeedbackGain', defaultFeedbackGain, validScalarPosNum);
    addParameter(p, 'DirectGain', defaultDirectGain, validScalarPosNum);
    addParameter(p, 'SampleRate', defaultSampleRate, validScalarPosNum);
    addParameter(p, 'CutFrequency', defaultLowpassCutFreq, validScalarPosNum);
    addParameter(p, 'Type', defaultFitlterType, ...
                          @(x) any(validatestring(x, expectedFilterType)));
    parse(p, varargin{:}); 

    if strcmpi(p.Results.Type, 'fir_comb')

        m = round(p.Results.SampleRate * p.Results.DelayTime);
        b = [1, zeros(1, m-1), p.Results.FeedforwardGain];
        a = 1;

    elseif strcmpi(p.Results.Type, 'iir_comb')

        m = round(p.Results.SampleRate * p.Results.DelayTime);
        b = p.Results.DirectGain;
        a = [1, zeros(1, m-1), -p.Results.FeedbackGain];

    elseif strcmpi(p.Results.Type, 'universal_comb')

        m = round(p.Results.SampleRate * p.Results.DelayTime);
        b = [p.Results.DirectGain, zeros(1, m-1), p.Results.FeedforwardGain];
        a=  [1, zeros(1, m-1), -p.Results.FeedbackGain];

    elseif strcmpi(p.Results.Type, 'natural_comb')

        K = tan(pi * p.Results.CutFrequency / p.Results.SampleRate);
        a0 = 1; a1 = (K-1) / (K+1); b0 = K / (K+1); b1 = K / (K+1);
        m = round(p.Results.SampleRate * p.Results.DelayTime);
        b = [p.Results.DirectGain*a0, p.Results.DirectGain*a1];
        a = [a0, a1, zeros(1, m-2), -p.Results.FeedbackGain*b0, -p.Results.FeedbackGain*b1];

    else

        return

    end

end