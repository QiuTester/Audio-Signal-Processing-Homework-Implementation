function varargout = Test_envelope_extractor(orig, varargin)
        
        path.type = 'String';
        path.default = [];
    option.path = path;
    
        method.type = 'String';
        method.choice = {'Filter','Spectro'};
        method.default = 'Filter';
    option.method = method;
    
        FilterType.key = 'FilterType';
        FilterType.type = 'String';
        FilterType.choice = {'HalfHann','Butter','IIR'};
        FilterType.default = 'IIR';
    option.FilterType = FilterType;
    
        CutOffFreq.key = 'CutOffFreq';
        CutOffFreq.type = 'Integer';
        CutOffFreq.default = 50;
    option.CutOffFreq = CutOffFreq;

        DownSamRate.key = 'DownSamRate';
        DownSamRate.type = 'Integer';
        DownSamRate.default = 20;
    option.DownSamRate = DownSamRate;
   
        FrameLength.key = 'FrameLength';
        FrameLength.type = 'Integer';
        FrameLength.default = .1;
    option.FrameLength = FrameLength;
    
        BandType.key = 'BandType';
        BandType.type = 'String';
        BandType.choice = {'Freq','Mel','Bark','Cents'};
        BandType.default = 'Freq';
    option.BandType = BandType;
      
        Operation.key = 'Operation';
        Operation.type = 'String';
        Operation.choice = {'Complex','Terbardt','TimeSmooth'};
    option.Operation = Operation;

specif.option = option;

varargout = mirfunction(@envelope_extractor,orig,varargin,nargout,specif,@init,@main);
    
function [x, type] = init(x, option)
type = 'envelope_exytractor';

function E = main(orig, option, postoption)

    E = orig;
    if strcmpi(option.method, 'Filter')
        
        if strcmpi(option.FilterType, 'HalfHann')
            Env = mirenvelope(option.path, 'Filter', 'FilterType','HalfHann', ...
            'CutOff',option.CutOffFreq, 'PostDecim', option.DownSamRate);
        elseif strcmpi(option.FilterType, 'Butter')
            Env = mirenvelope(option.path, 'Filter', 'FilterType','Butter', ...
            'CutOff',option.CutOffFreq, 'PostDecim', option.DownSamRate);
        elseif strcmpi(option.FilterType, 'IIR')
            Env = mirenvelope(option.path, 'Filter', 'FilterType','IIR', ...
            'CutOff',option.CutOffFreq, 'PostDecim', option.DownSamRate);
        end
        
    else
        
        if strcmpi(option.BandType, 'Freq')
            Env = mirenvelope(path, 'Spectro', 'Frame',option.FrameLength, ...
                                  b, 'Freq', option.Operation);
        elseif strcmpi(option.BandType, 'Mel')
            Env = mirenvelope(path, 'Spectro', 'Frame',option.FrameLength, ...
                                  b, 'Mel', option.Operation);
        elseif strcmpi(option.BandType, 'Bark')
            Env = mirenvelope(path, 'Spectro', 'Frame',option.FrameLength, ...
                                  b, 'Bark', option.Operation);
        elseif strcmpi(option.BandType, 'Cents')
            Env = mirenvelope(path, 'Spectro', 'Frame',option.FrameLength, ...
                                  b, 'Cents', option.Operation);
        end
    
    end
    
E = set(E, 'Data', Env);
    

