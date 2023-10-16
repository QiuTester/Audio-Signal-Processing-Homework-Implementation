function signal_contrast = spectral_contrast(s, f)
    bark_bands = [20, 100, 200, 300, 400, 510, 630, 770, 920, 1080, 1270, 1480, 1720, 2000, 2320, ...
        2700, 3150, 3700, 4400, 5300, 6400, 7700, 9500, 12000, 15500, 20000];
    signal_contrast = [ ];
    for i = 1 : size(s, 2)
        ener_spec = s(:, i) .^ 2;
        index = [ ];
        band_contrast = [ ];
        for band = 2 : length(bark_bands)
            band_ener_sorted = [ ];
            index = find(f >= bark_bands(band-1) & f < bark_bands(band));
            if length(index) == 1 || isempty(index)
                band_contrast(band-1) = 0;
            else
                band_ener_sorted = sort(ener_spec(index), 'descend');
                quantile = floor(length(band_ener_sorted) / 2); 
                peak_ener = sum(band_ener_sorted(1:quantile));
                valley_ener = sum(band_ener_sorted(quantile+1:end));
                band_contrast(band-1) = log10(peak_ener/valley_ener) / log10(sum(band_ener_sorted) / length(band_ener_sorted));
            end
        end
        signal_contrast(:, i) = band_contrast;
    end
    signal_contrast = normalize(signal_contrast);
end







