function [dct_with_watermark, dct_audio_with_watermark] = add_watermark(Y_dct, watermark_dct, watermark_size)
    dct_with_watermark= [Y_dct' watermark_dct'];
    dct_with_watermark = dct_with_watermark';

    D = Y_dct;
    D(end-(watermark_size^2)+1 : end) = watermark_dct;
    dct_audio_with_watermark = D;
end