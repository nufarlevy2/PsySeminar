function [ output_args ] = getAllContrastedImages( my_struct, dapi4Threshold, dapi5Threshold, dapi20Threshold, fos4Threshold, fos5Threshold, fos20Threshold )
    for i = 1:length(my_struct)
        disp(my_struct(i));
        if my_struct(i).isDAPI == 1 && my_struct(i).magnification == 4
            getContrastOfImage(my_struct(i).fullPath, dapi4Threshold, 0.5);
        elseif my_struct(i).isDAPI == 1 && my_struct(i).magnification == 20
            getContrastOfImage(my_struct(i).fullPath, dapi20Threshold, 0.5);
        elseif my_struct(i).isFos == 1 && my_struct(i).magnification == 4
            getContrastOfImage(my_struct(i).fullPath, fos4Threshold, 0.5);
        elseif my_struct(i).isFos == 1 && my_struct(i).magnification == 20
            getContrastOfImage(my_struct(i).fullPath, fos20Threshold, 0.5);
        elseif my_struct(i).isFos == 1 && my_struct(i).magnification == 5
            getContrastOfImage(my_struct(i).fullPath, fos5Threshold, 0.5);
        elseif my_struct(i).isDAPI == 1 && my_struct(i).magnification == 5
            getContrastOfImage(my_struct(i).fullPath, dapi5Threshold, 0.5);
        end
    end
end

