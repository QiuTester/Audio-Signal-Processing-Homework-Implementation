clc; clear; close all;

addpath("homework6_function/.");

audioname = './audiofile/woman_voice.wav';
imgname = './imagefile/qiu_watermark2.jpg';
time = double(audioinfo(audioname).Duration);

[y, sr] = audioread(audioname);
y = y(:, 1);
img_data = im2gray(imread(imgname));

watermark_size = 150;
w_pass = 2000;

[Y_dct, audio_dct_length] = audio_dct(y, 99.5); % Audio's DCT
[watermark_dct, image_row_num, image_list_num] = img_dct(img_data, watermark_size); % Image watermark's DCT
[dct_with_watermark, dct_audio_with_watermark] = add_watermark(Y_dct, watermark_dct, watermark_size); % add the watermark to audio signal
[audio_with_watermark_inverse, audio_inverse, image_inverse] = watermark_reduction(dct_with_watermark, dct_audio_with_watermark, image_row_num, image_list_num, watermark_size); % restore the audio and image signal from the added signal
audio_inverse_filted = plot_and_sound(y, sr, time, img_data, Y_dct, watermark_dct, dct_with_watermark, audio_inverse, image_inverse, audio_with_watermark_inverse, w_pass); % show the difference 

audiowrite('new_audio/woman_voice_inverse.wav', audio_inverse, sr); 
audiowrite('new_audio/woman_voice_inverse_filted.wav', audio_inverse_filted, sr);
audiowrite('new_audio/woman_voice_with_watermark.wav', audio_with_watermark_inverse, sr);