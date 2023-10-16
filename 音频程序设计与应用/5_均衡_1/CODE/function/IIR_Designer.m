function AudioFilted = IIR_Designer(AudioData, Fs, Fc, Fb, Type)

  K = tan(pi * Fc / Fs); N = 512;
  
  if strcmpi(Type, 'Order1-HighPass')
      b = [1/(K+1), -1/(K+1)]; a = [1, (K-1)/(K+1)];
   
  elseif strcmpi(Type, 'Order2-HighPass')
      Q = 1/(2^0.5); D = K^2*Q+K+Q;
      b = [Q/(K^2*Q+K+Q), -2*Q/D, Q/D]; a = [1, 2*Q*(K^2-1)/D, (D-2*K)/D];

  elseif strcmpi(Type, 'Order2-BandPass')
      Q = Fc / Fb; D = K^2*Q+K+Q;
      b = [K/D, 0, -K/D]; a = [1, 2*Q*(K^2-1)/D, (D-2*K)/D];
  
  elseif strcmpi(Type, 'Order2-BandStop')
      Q = Fc / Fb; D = K^2*Q+K+Q;
      b = [Q*(1+K^2)/D, 2*Q*(K^2-1)/D, Q*(1+K^2)/D];
      a = [1, 2*Q*(K^2-1)/D, (D-2*K)/D];

  else
      return 

  end

  figure(); freqz(b, a, N, Fs);  

  AudioFilted = filter(b, a, AudioData);

  L = length(AudioData); P = nextpow2(L); FFT_n = pow2(P);

  AudioDataFreq = abs(fft(AudioData, FFT_n)); AudioDataFreq = AudioDataFreq(1 : round(end/2+1));
  AudioFiltedFreq = abs(fft(AudioFilted, FFT_n)); AudioFiltedFreq = AudioFiltedFreq(1 : round(end/2+1));

  figure();
  FreqAxis = linspace(Fs/FFT_n, Fs/2, FFT_n/2+1);
  subplot(2, 1, 1); plot(FreqAxis, normalize(AudioDataFreq)); title('Original Frequency Domain')
  subplot(2, 1, 2); plot(FreqAxis, normalize(AudioFiltedFreq)); title('Filted Frequency Domain')

end