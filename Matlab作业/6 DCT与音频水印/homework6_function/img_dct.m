function [watermark_dct, image_row_num, image_list_num] = img_dct(img_data, watermark_size)
    Img_dct = dct2(img_data);
    [~, index] = sort(abs(Img_dct), 2, 'descend');
    for i = 1:size(Img_dct, 1)
        Img_dct(i, index(i, (watermark_size+1) : end)) = 0;
    end
    image_row_num = size(Img_dct, 1);
    image_list_num = size(Img_dct, 2);
    Img_dct = Img_dct(1:watermark_size, 1:watermark_size);
    watermark_dct = Img_dct(:);             % image's DCT data dimensionality reduction
    watermark_dct = watermark_dct / max(watermark_dct);
end