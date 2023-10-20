function  add_harmonicty(y, sr, f1, monophonic_ratio, monophonic_TS)
    
    y_envelope = envelope(y, 150, 'analytic');
    y_envelope = y_envelope / max(abs(y_envelope));
    t = 0 : 1/sr : (length(y)-1)/sr;
    sine_wave = sin(2*pi*f1* t.*(1:12)');

    sin_wave2_4 = monophonic_TS(2) * (sine_wave2 + monophonic_ratio(3)*sine_wave3 + sine_wave4);
    sin_wave5_12 = monophonic_TS(3) * (monophonic_ratio(3)*sine_wave5 + monophonic_ratio(2)*sine_wave6 ...
                                                               + monophonic_ratio(2)*monophonic_ratio(3)*sine_wave7+monophonic_ratio(2)*sine_wave8 ...
                                                               +monophonic_ratio(2)*monophonic_ratio(3)*sine_wave9 + monophonic_ratio(2)*sine_wave10 ...
                                                               + monophonic_ratio(2)*monophonic_ratio(3)*sine_wave11 + monophonic_ratio(2)*sine_wave12);

    sin_final = (monophonic_ratio(3)*sine_wave1 + sin_wave2_4 + sin_wave5_12);
    sin_final = sin_final / max(abs(sin_final));
    sin_final = sin_final .* y_envelope'; 
    sound(sin_final, sr);
    audiowrite('new_audio/tuba_sin.wav', sin_final, sr);
end

    


