function audio_processing(x, sr)
    y_iir_lowpass_10 = IIR_lowpass_10(x);
    y_iir_lowpass_50 = IIR_lowpass_50(x);
    y_fir_lowpass_10 = FIR_lowpass_10(x);
    y_fir_lowpass_50 = FIR_lowpass_50(x);
    y_iir_highpass_10 = IIR_highpass_10(x);
    y_iir_highpass_50 = IIR_highpass_50(x);
    y_fir_highpass_10 = FIR_highpass_10(x);
    y_fir_highpass_50 = FIR_highpass_50(x);

    [phase_iir_lowpass_10, F] = phase_calculation(y_iir_lowpass_10, sr);
    [phase_iir_lowpass_50, F] = phase_calculation(y_iir_lowpass_50, sr);
    [phase_fir_lowpass_10, F] = phase_calculation(y_fir_lowpass_10, sr);
    [phase_fir_lowpass_50, F] = phase_calculation(y_fir_lowpass_50, sr);
    [phase_iir_highpass_10, F] = phase_calculation(y_iir_highpass_10, sr);
    [phase_iir_highpass_50, F] = phase_calculation(y_iir_highpass_50, sr);
    [phase_fir_highpass_10, F] = phase_calculation(y_fir_highpass_10, sr);
    [phase_fir_highpass_50, F] = phase_calculation(y_fir_highpass_50, sr);

    figure()
    subplot(4, 2, 1); plot(F, phase_iir_lowpass_10); xlabel('Frequency/Hz'); title('IIR Order-10 Lowpass filter')
    subplot(4, 2, 2); plot(F, phase_iir_lowpass_50); xlabel('Frequency/Hz'); title('IIR Order-50 Lowpass filter')
    subplot(4, 2, 3); plot(F, phase_fir_lowpass_10); xlabel('Frequency/Hz'); title('FIR Order-10 Lowpass filter')
    subplot(4, 2, 4); plot(F, phase_fir_lowpass_50); xlabel('Frequency/Hz'); title('FIR Order-50 Lowpass filter')
    subplot(4, 2, 5); plot(F, phase_iir_highpass_10); xlabel('Frequency/Hz'); title('IIR Order-10 Highpass filter')
    subplot(4, 2, 6); plot(F, phase_iir_highpass_50); xlabel('Frequency/Hz'); title('IIR Order-50 Highpass filter')
    subplot(4, 2, 7); plot(F, phase_fir_highpass_10); xlabel('Frequency/Hz'); title('FIR Order-10 Highpass filter')
    subplot(4, 2, 8); plot(F, phase_fir_highpass_50); xlabel('Frequency/Hz'); title('FIR Order-50 Highpass filter')

    audiowrite("new_audio/IIR_Order10_lowpass.wav", y_iir_lowpass_10, sr);
    audiowrite("new_audio/IIR_Order50_lowpass.wav", y_iir_lowpass_50, sr);
    audiowrite("new_audio/FIR_Order10_lowpass.wav", y_fir_lowpass_10, sr);
    audiowrite("new_audio/FIR_Order50_lowpass.wav", y_fir_lowpass_50, sr);
    audiowrite("new_audio/IIR_Order10_highpass.wav", y_iir_highpass_10, sr);
    audiowrite("new_audio/IIR_Order50_highpass.wav", y_iir_highpass_50, sr);
    audiowrite("new_audio/FIR_Order10_highpass.wav", y_fir_highpass_10, sr);
    audiowrite("new_audio/FIR_Order50_highpass.wav", y_fir_highpass_50, sr);
    
end

