function signal_inharmo = Inharmonicity(s, f, baseband)
    signal_inharmo = [ ];
    for i = 1 : size(s, 2)
        spec = envelope(s(:, i), 150, 'rms');
        [~, locs] = findpeaks(spec, NPeaks=7);
        for h = 1 : 7
            molecular(h) = abs( f(locs(h)) - h*baseband ) * ( s(locs(h), i).^2 );
            denominator(h) = s(locs(h), i).^2;
        end
        signal_inharmo(i) = (2/baseband) * ( sum(molecular)/sum(denominator) );
    end
    signal_inharmo = signal_inharmo / max(signal_inharmo);
end

