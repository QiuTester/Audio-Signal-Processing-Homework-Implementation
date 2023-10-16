function [OutputSig, Weights] = SingleChannelWeiner_filter(InputSig, DesireSig, order, step)

    LMS_Filter = dsp.LMSFilter('Method','LMS', 'Length',order, 'StepSize',step);
    [OutputSig, Error, Weights] = LMS_Filter(InputSig, DesireSig);
    
end

