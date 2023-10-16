clc; clear; close all;

addpath('function/')

% 
% FilterbankLow = mirfilterbank('test1_1.wav', '2Channels', 'Channels',1);
% FilterbankHigh = mirfilterbank('test1_1.wav', '2Channels', 'Channels',2);
% 
% peak1 = mirevents(FilterbankLow, 'Pitch', 'Threshold',0.3, 'Contrast',0.1);
% peak2 = mirevents(FilterbankHigh, 'Pitch', 'Threshold',0.3, 'Contrast',0.1);
% 
% seg1 = mirsegment('test1_1.wav', peak1);
% seg2 = mirsegment('test1_1.wav', peak2);
% 
% curve1 = mirpitch(seg1, 'Frame', 'Total',1, 'Threshold',0.1, 'Sum',1);
% curve2 = mirpitch(seg2, 'Frame', 'Total',1, 'Threshold',0.1, 'Sum',1);
% 
% a = mirgetdata(curve1);
% Pitch_curve1 = [];
% for i = 1:size(a, 2)
%     Pitch_curve1 = [Pitch_curve1 a{i}];
% end
% plot(Pitch_curve1)
% 
% b = mirgetdata(curve2);
% Pitch_curve2 = [];      
% for i = 1:size(b, 2)
%     Pitch_curve2 = [Pitch_curve2 b{i}];
% end
% figure()
% plot(Pitch_curve2)

% Pitch_Extractor('chorus.wav', 'IfMono','true', 'Filterbank','Gammatone', 'MinValue',60, 'MaxValue',2400, 'Threshold',0.2, ...
%                                'Contrast',0.1, 'MedianLength',0.01, 'Segment', 'Nymoen');

bpm = Rhythm_Extractor('ensemble.wav', 'BandsType','Bark', 'FreqRange',10, 'FreqResolution',0.01, 'IfSum','false',...
                                         'InstrumentRange',5, 'Threshold',10, 'BeatSpec', 'false');
