clc; clear; close all;

addpath('function/.')

global  CompensationCurve; global N; global Fs
Fc = 2000; Fs = 48000; N = 1024;
H = IIRCanonicalLowPass(Fc, Fs, N, 2);

OriginalPhase = unwrap(angle(H))*180 / pi;
IdealCurve = linspace(OriginalPhase(1), OriginalPhase(end), N)';
CompensationCurve = IdealCurve - OriginalPhase;

figure(); 
subplot(2, 1, 1); plot(IdealCurve); title('Ideal Phase Response')
subplot(2, 1, 2); plot(CompensationCurve); title('Compensation Phase Response')

Options = optimoptions('ga', 'PlotFcn',@gaplotbestf);

% First order filter options
% Options.ConstraintTolerance = 1e-6;
% Options.MaxGenerations = 500;
% Options.FunctionTolerance = 1e-6;
% Options.MigrationFraction = 0.2;

% Second order filter options
Options.ConstraintTolerance = 1e-6;
Options.MaxGenerations = 500;
Options.FunctionTolerance = 1e-6;
Options.MigrationFraction = 0.2;

[X, fval] = ga(@CompensationAppropriate, 2, [], [], [], [], [], [], [], [], Options);

freqz([X(2) X(1) 1], [1 X(1) X(2)], N, Fs)
[CompensatedResponse] = freqz([X(2) X(1) 1], [1 X(1) X(2)], N, Fs);
CompensatedPhase = unwrap(angle(CompensatedResponse))*180 / pi;

figure();
plot(OriginalPhase, 'Color', 'b'); hold on;
plot(CompensatedPhase, 'Color', 'r'); hold on;
plot(OriginalPhase+CompensatedPhase, 'Color', 'black')

