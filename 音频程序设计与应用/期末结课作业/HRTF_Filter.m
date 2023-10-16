clc; clear()

SOFAstart;

hrir = SOFAload('IRC_1101_C_HRIR_96000.sofa');
global Desire_HRTF;
Desire_HRTF = zeros(1, 1024)';

Impulse_Response = reshape(hrir.Data.IR(1, :, :), 2, 2048);
FR = abs(fft(Impulse_Response(1, :), 2048));
HRTF = FR(2 : length(FR)/2+1)';
Desire_HRTF(2:end-1) = 2 * HRTF(2:end-1);

% Second order filter options
Options.ConstraintTolerance = 1e-6;
Options.MaxGenerations = 500;
Options.FunctionTolerance = 1e-6;
Options.MigrationFraction = 0.2;

[X, fval] = ga(@CompensationAppropriate, 2, [], [], [], [], [], [], [], [], Options);

function Delta = CompensationAppropriate(Tap)

    global Desire_HRTF;

    CurrentFR = freqz([Tap(2) Tap(1) 1], [1 1 1], 1024, 48000);
    Diff = abs(Desire_HRTF - CurrentFR);
    Delta = sum(Diff);

end