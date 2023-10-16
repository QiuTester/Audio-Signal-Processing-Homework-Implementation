function [audio_with_watermark_inverse, audio_inverse, image_inverse] = watermark_reduction( ...
                                                       dct_with_watermark, dct_audio_with_watermark, image_row_num, image_list_num, watermark_size)

    audio_with_watermark_inverse = idct(dct_audio_with_watermark);

    image_dct = dct_with_watermark(end-(watermark_size^2)+1 : end);
    image_dct = reshape(image_dct, watermark_size, watermark_size);
    image_dct(image_row_num, image_list_num) = 0;
    image_inverse = rescale(idct2(image_dct));
    audio_inverse = idct(dct_with_watermark(1 : end-(watermark_size^2) ));
end

