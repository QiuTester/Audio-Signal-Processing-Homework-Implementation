clc; clear; close all;

addpath('./function/')

%Test1 = envelope_extractor('piano_test.wav', 'method','Filter', 'FilterType','IIR', 'DownSamRate',20);
%Test2 = envelope_extractor('piano_test.wav', 'method','Filter', 'FilterType','IIR', 'DownSamRate',500);
%Test3 = envelope_extractor('piano_test.wav', 'method','Filter', 'FilterType','IIR', 'DownSamRate',10000);
%Test4 = envelope_extractor('xylophone_test.wav', 'method','Filter', 'FilterType','IIR', 'DownSamRate',20);
%Test5 = envelope_extractor('xylophone_test.wav', 'method','Filter', 'FilterType','IIR', 'DownSamRate',20);
%Test6 = envelope_extractor('xylophone_test.wav', 'method','Filter', 'FilterType','IIR', 'DownSamRate',20);

% Test1 = envelope_extractor('piano_test.wav', 'method','Spectro', 'FrameLength',0.1, 'Operation','Complex');
% Test2 = envelope_extractor('piano_test.wav', 'method','Spectro', 'FrameLength',0.1, 'Operation', 'Terhardt');
% Test3 = envelope_extractor('piano_test.wav', 'method','Spectro', 'FrameLength',0.1, 'Operation', 'TimeSmooth');
% Test4 = envelope_extractor('xylophone_test.wav', 'method','Spectro', 'FrameLength',0.1, 'Operation','Complex');
% Test5 = envelope_extractor('xylophone_test.wav', 'method','Spectro', 'FrameLength',0.1, 'Operation', 'Terhardt');
% Test6 = envelope_extractor('xylophone_test.wav', 'method','Spectro', 'FrameLength',0.1, 'Operation', 'TimeSmooth');

% Test1 = f0_extractor('piano_test.wav', 'method','AutoCorr', 'MinValue',0.0002, 'MaxValue',0.1, 'IfEnhanced', 'Enhanced');
% Test2 = f0_extractor('piano_test.wav', 'method','AutoCorr', 'MinValue',0.001, 'MaxValue', 0.01, 'IfEnhanced', 'Enhanced');
% Test3 = f0_extractor('piano_test.wav', 'method','AutoCorr', 'MinValue', 0.002, 'MaxValue', 0.01, 'IfEnhanced', 'Enhanced');
% Test4 = f0_extractor('xylophone_test.wav', 'method','AutoCorr', 'MinValue',0.0002, 'MaxValue',0.1, 'IfEnhanced', 'Enhanced');
% Test5 = f0_extractor('xylophone_test.wav', 'method','AutoCorr', 'MinValue',0.001, 'MaxValue',0.01, 'IfEnhanced', 'Enhanced');
% Test6 = f0_extractor('xylophone_test.wav', 'method','AutoCorr', 'MinValue',0.002, 'MaxValue',0.01, 'IfEnhanced', 'Enhanced');

% Test1 = f0_extractor('piano_test.wav', 'method','Cepstrum', 'MinValue',0.0002, 'MaxValue',0.1, 'IfComplex', 'Complex');
% Test2 = f0_extractor('piano_test.wav', 'method','Cepstrum', 'MinValue',0.001, 'MaxValue', 0.01, 'IfComplex', 'Complex');
% Test3 = f0_extractor('piano_test.wav', 'method','Cepstrum', 'MinValue', 0.002, 'MaxValue', 0.01, 'IfComplex', 'Complex');
% Test4 = f0_extractor('xylophone_test.wav', 'method','Cepstrum', 'MinValue',0.0002, 'MaxValue',0.1);
% Test5 = f0_extractor('xylophone_test.wav', 'method','Cepstrum', 'MinValue',0.001, 'MaxValue',0.01);
% Test6 = f0_extractor('xylophone_test.wav', 'method','Cepstrum', 'MinValue',0.002, 'MaxValue',0.01);

% note_detector('piano_test.wav', 'method','Segment', 'ChannelNum',7, 'ComputeWay','Pitch', 'SegMethod','Novelty');
% note_detector('piano_test.wav', 'method','Segment', 'ChannelNum',7, 'ComputeWay','Pitch', 'SegMethod','HCDF');
% note_detector('piano_test.wav', 'method','Segment', 'ChannelNum',7, 'ComputeWay','Pitch', 'SegMethod','RMS');
% note_detector('xylophone_test.wav', 'method','Segment', 'ChannelNum',7, 'ComputeWay','Pitch', 'SegMethod','Novelty');
% note_detector('xylophone_test.wav', 'method','Segment', 'ChannelNum',7, 'ComputeWay','Pitch', 'SegMethod','HCDF');
% note_detector('xylophone_test.wav', 'method','Segment', 'ChannelNum',7, 'ComputeWay','Pitch', 'SegMethod','RMS');

[peak_loc1, valley_loc1] = note_detector('piano_test.wav', 'method','Valley', 'ChannelNum',7, 'ComputeWay','Pitch', 'SegMethod','Novelty');
[peak_loc2, valley_loc2] = note_detector('piano_test.wav', 'method','Valley', 'ChannelNum',7, 'ComputeWay','Pitch', 'SegMethod','HCDF');
[peak_loc3, valley_loc3] = note_detector('piano_test.wav', 'method','Valley', 'ChannelNum',7, 'ComputeWay','Pitch', 'SegMethod','RMS');
[peak_loc4, valley_loc4] = note_detector('xylophone_test.wav', 'method','Valley', 'ChannelNum',7, 'ComputeWay','Pitch', 'SegMethod','Novelty');
[peak_loc5, valley_loc5] = note_detector('xylophone_test.wav', 'method','Valley', 'ChannelNum',7, 'ComputeWay','Pitch', 'SegMethod','HCDF');
[peak_loc6, valley_loc6] = note_detector('xylophone_test.wav', 'method','Valley', 'ChannelNum',7, 'ComputeWay','Pitch', 'SegMethod','RMS');

% subplot(3, 2, 1); plot(Test1);
% subplot(3, 2, 3); plot(Test2);
% subplot(3, 2, 5); plot(Test3);
% subplot(3, 2, 2); plot(Test4);
% subplot(3, 2, 4); plot(Test5);
% subplot(3, 2, 6); plot(Test6);