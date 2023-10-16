function audio_inverse_filted = plot_and_sound(y, sr, time, img_data, Y_dct, ...
                                            watermark_dct, dct_with_watermark, audio_inverse, image_inverse, audio_with_watermark_inverse, w_pass)
    figure(); 
    subplot(3, 1, 1); plot(abs(Y_dct)); title('DCT-Audio');
    subplot(3, 1, 2); plot(abs(watermark_dct)); title('DCT-Image watermark');
    subplot(3, 1, 3); plot(abs(dct_with_watermark)); title('DCT-Audio with watermark');

    audio_inverse_filted = lowpass(audio_inverse, w_pass, sr, Steepness=0.999);
    figure();
    subplot(4, 1, 1); plot(y); title('Original audio wave');                
    subplot(4, 1, 2); plot(audio_inverse); title('Restored audio wave');
    subplot(4, 1, 3); plot(audio_inverse_filted); title('Restored audio after 1500Hz lowpass filter');
    subplot(4, 1, 4); plot(audio_with_watermark_inverse); title('Restored audio(with watermark)wave');
    sound(y, sr); pause(time);
    sound(audio_inverse, sr); pause(time);
    sound(audio_inverse_filted, sr); pause(time);
    sound(audio_with_watermark_inverse, sr);

    figure(); 
    montage({img_data, image_inverse});
end