function y = FIR_highpass_10(x)
%FIR_HIGHPASS_10 对输入 x 进行滤波并返回输出 y。

% MATLAB Code
% Generated by MATLAB(R) 9.11 and DSP System Toolbox 9.13.
% Generated on: 18-Nov-2022 14:36:12

%#codegen

% 要通过此函数生成 C/C++ 代码，请使用 codegen 命令。有关详细信息，请键入 'help codegen'。

persistent Hd;

if isempty(Hd)
    
    % 设计滤波器系数时使用了以下代码:
    % % Equiripple Highpass filter designed using the FIRPM function.
    %
    % % All frequency values are in Hz.
    % Fs = 48000;  % Sampling Frequency
    %
    % N     = 10;    % Order
    % Fstop = 3000;  % Stopband Frequency
    % Fpass = 6000;  % Passband Frequency
    % Wstop = 1;     % Stopband Weight
    % Wpass = 1;     % Passband Weight
    % dens  = 20;    % Density Factor
    %
    % % Calculate the coefficients using the FIRPM function.
    % b  = firpm(N, [0 Fstop Fpass Fs/2]/(Fs/2), [0 0 1 1], [Wstop Wpass], ...
    %            {dens});
    
    Hd = dsp.FIRFilter( ...
        'Numerator', [0.0382717295953464 -0.0881945953338373 ...
        -0.110797397603952 -0.147820721311024 -0.177474331991395 ...
        0.811551539213032 -0.177474331991395 -0.147820721311024 ...
        -0.110797397603952 -0.0881945953338373 0.0382717295953464]);
end

y = step(Hd,double(x));


% [EOF]
