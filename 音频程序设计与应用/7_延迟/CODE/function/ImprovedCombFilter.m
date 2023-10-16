function [b, a] = ImprovedCombFilter(varargin)

    defaultIfDelayTime = 0.2;
    defaultSideChainGain = 0.6;
    defaultBLValue= 0.1;
    defaultFFValue = 0.1;
    defaultFBValue = 0.1;
    defaultSampleRate = 48000;
    defaultLowpassCutFreq = 500;
    defaultBaseStructureChoice = 'FIR_Direct';
    expectedBaseStructureChoice = {'FIR_Direct', 'FIR_Reflected', 'Universal'};

    p = inputParser;
    validScalarPosNum = @(x) isscalar(x) && (x > 0);
    addParameter(p, 'DelayTime', defaultIfDelayTime, validScalarPosNum);
    addParameter(p, 'SideChainGain', defaultSideChainGain, validScalarPosNum);
    addParameter(p, 'BL', defaultBLValue, validScalarPosNum);
    addParameter(p, 'FF', defaultFFValue, validScalarPosNum);
    addParameter(p, 'FB', defaultFBValue, validScalarPosNum);
    addParameter(p, 'SampleRate', defaultSampleRate, validScalarPosNum);
    addParameter(p, 'CutFrequency', defaultLowpassCutFreq, validScalarPosNum);
    addParameter(p, 'Type', defaultBaseStructureChoice, ...
                          @(x) any(validatestring(x,expectedBaseStructureChoice)));
    parse(p, varargin{:}); 

    K = tan(pi* p.Results.CutFrequency/p.Results.SampleRate);
    a0 = 1;  a1 = (K-1) / (K+1);
    b0 = K/(K+1);  b1 = K/(K+1);
    M = round(p.Results.SampleRate * p.Results.DelayTime);

    if strcmpi(p.Results.Type, 'FIR_Direct')

        b = [zeros(1, M),  (b0+p.Results.SideChainGain), (b1+p.Results.SideChainGain*a1)];
        a = [1, a1];

    elseif strcmpi(p.Results.Type, 'FIR_Reflected')

        b = [1,  a1, zeros(1, M-2), (b0*p.Results.SideChainGain), (b1*p.Results.SideChainGain)];
        a = [1, a1];

    elseif strcmpi(p.Results.Type, 'Universal')

        b = [p.Results.BL, 2*p.Results.BL*a1, p.Results.BL*a1^2, zeros(1, M-3), p.Results.FF, p.Results.FF*(b1+a1*b0), p.Results.FF*a1*b1];
        a = [1, 2*a1, a1^2, zeros(1, M-3), -(p.Results.FB*b0^2), -(2*p.Results.FB*b1*b0), -(p.Results.FB*b1^2)];

    else

        return

    end

end