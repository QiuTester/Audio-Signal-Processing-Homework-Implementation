function AudioFilted = FIR_Designer(AudioData, Fs, Order, CutOffFreq, FilterType)
 
    FilterCodefficients = fir1(Order, CutOffFreq, FilterType);

    figure(); impz(FilterCodefficients, 1); title(FilterType);

    figure(); freqz(FilterCodefficients, 1, Order, Fs)

    AudioFilted = filter(FilterCodefficients, 1, AudioData);

    L = length(AudioData); P = nextpow2(L); FFT_n = pow2(P);
    
    AudioDataFreq = abs(fft(AudioData, FFT_n)); AudioDataFreq = AudioDataFreq(1 : round(end/2+1));
    AudioFiltedFreq = abs(fft(AudioFilted, FFT_n)); AudioFiltedFreq = AudioFiltedFreq(1 : round(end/2+1));
    
    figure();
    FreqAxis = linspace(Fs/FFT_n, Fs/2, FFT_n/2+1);
    subplot(2, 1, 1); plot(FreqAxis, normalize(AudioDataFreq)); title('Original Frequency Domain')
    subplot(2, 1, 2); plot(FreqAxis, normalize(AudioFiltedFreq)); title('Filted Frequency Domain')
    
end

