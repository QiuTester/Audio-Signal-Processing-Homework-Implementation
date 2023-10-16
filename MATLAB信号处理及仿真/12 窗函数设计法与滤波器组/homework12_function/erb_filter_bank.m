function  [F0, Y_bank_filted, freq] = erb_filter_bank(y, sr, nfft)
    Y = fft(y, nfft);
    Y = abs(Y(1 : nfft/2));

    f_low = 0; f_high = sr / 2;
    erb_l = v_frq2erb(f_low); erb_h = v_frq2erb(f_high);
    n_filter = 40;
    E = erb_h - erb_l;
    F0 = v_erb2frq(linspace(0, E, n_filter+2)); % include the sample of frequency zero and sr/2

    gammatone_filter_bank = [ ];
    y_bank_filter = zeros(n_filter, nfft);
    figure()
    for i = 1 : n_filter
        gammatone_filter_bank = gammatone_filter_design(nfft, sr, F0(i+1));
        gammatone_filter_bank = gammatone_filter_bank / max(gammatone_filter_bank);
        plot(gammatone_filter_bank); hold on
        Y_bank_filted(i, :) = gammatone_filter_bank' .*  Y;
    end

    freq = linspace(sr/nfft, sr/2, nfft/2);
end

