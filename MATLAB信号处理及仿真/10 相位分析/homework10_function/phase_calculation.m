function [pha_fft, F] = phase_calculation(x, sr)
    L = length(x);
    P = nextpow2(L);
    N = pow2(P);
    
    fft_data = fft(x, N);
    fft_data = fft_data(1 : N/2);
    pha_fft = unwrap(angle(fft_data));

     F = linspace(sr/N, sr/2, N/2);
end

