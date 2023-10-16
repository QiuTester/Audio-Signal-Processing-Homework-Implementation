function  add_harmonicty(y, sr, f1, monophonic_ratio, monophonic_TS)
    [f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12] = deal(f1*2, f1*3, f1*4, f1*5, f1*6, f1*7, f1*8, f1*9, f1*10, f1*11, f1*12);
    y_envelope = envelope(y, 150, 'analytic');
    y_envelope = y_envelope / max(abs(y_envelope));
    t = 0 : 1/sr : (length(y)-1)/sr;
    sine_wave1 = sin(2*pi*f1*t);
    sine_wave2 = sin(2*pi*f2*t);
    sine_wave3 = sin(2*pi*f3*t);
    sine_wave4 = sin(2*pi*f4*t);
    sine_wave5 = sin(2*pi*f5*t);
    sine_wave6 = sin(2*pi*f6*t);
    sine_wave7 = sin(2*pi*f7*t);
    sine_wave8 = sin(2*pi*f8*t);
    sine_wave9 = sin(2*pi*f9*t);
    sine_wave10 = sin(2*pi*f10*t);
    sine_wave11 = sin(2*pi*f11*t);
    sine_wave12 = sin(2*pi*f12*t);

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

    


