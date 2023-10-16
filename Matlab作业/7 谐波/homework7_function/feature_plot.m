function feature_plot(signal_slope, signal_entropy, signal_flatness, signal_irregularity, signal_flux, signal_roll_off, signal_contrast, ...
    signal_ratio, signal_TS, signal_inharmo)
    
    figure('Name','Harmonicity Envelope');
    subplot(4, 1, 1); plot(signal_slope); title('Spectral Slope')
    subplot(4, 1, 2); plot(signal_entropy);title('Spectral Entropy')
    subplot(4, 1, 3); plot(signal_flatness);title('Spectral Flatness Measurement')
    subplot(4, 1, 4); plot(signal_irregularity);title('Spectral Irregularity')

    figure('Name','Harmonicity Structure');
    subplot(3, 2, 1); plot(signal_flux);title('Spectral Flux')
    subplot(3, 2, 2); plot(signal_roll_off);title('Spectral Roll-off')
    subplot(3, 2, 3); pcolor(signal_contrast); shading interp; title('Spectral Contrast')
    subplot(3, 2, 4); pcolor(signal_ratio); shading interp; colorbar; colormap(jet); title('Hamonicity Ratio')
    subplot(3, 2, 5); pcolor(signal_TS); shading interp; colorbar; colormap(jet); title('TriStimulus')
    subplot(3, 2, 6); plot(signal_inharmo);title('Inharmonicity')
end

