function Response = IIRCanonicalLowPass(Fc, Fs, N, Order)
    
    K = tan(pi * Fc / Fs); Q = 1 / sqrt(2); 
    D = (K^2)*Q + K + Q;

    if Order==1
        b = [K/(K+1), K/(K+1)]; a = [1, (K-1)/(K+1)];

    elseif Order==2
        b = [(K^2)*Q/D, 2*(K^2)*Q/D, (K^2)*Q/D]; a = [1, 2*Q*(K^2-1)/D, ((K^2)*Q-K+Q)/D];
     
    else 
        return

    end

    freqz(b, a, N, Fs)

    Response = freqz(b, a, N, Fs);

end

