function fft_h = gammatone_filter_design(nfft, sr, f0)
    g = @(t,f0,erb) t.^3.*exp(-2*pi*1.019*erb*t).*cos(2*pi*f0*t);
    t = 0 : 1/sr : 0.5;
    erb = 24.7*(4.37*f0/1000 + 1);
    h = g(t, f0, erb);
    fft_h = fft(h, nfft);
    fft_h = abs(fft_h(1:nfft/2));
end

