function [Y_spec, ff] = FFT_monophoic(y, sr)
    P = nextpow2(length(y));
    N = pow2(P);
    Y = fft(y, N);
    Y_spec = abs(Y(2 : N/2+1));
    ff = linspace(sr/N, sr/2, N/2-1)';
    Y_spec = Y_spec / max(Y_spec);
    figure("Name", 'Spectrum');
    plot(Y_spec)
end

