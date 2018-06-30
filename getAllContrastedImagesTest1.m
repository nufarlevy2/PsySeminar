function [ output_args ] = getAllContrastedImagesTest1( my_struct, dapi4Threshold, dapi5Threshold, dapi20Threshold, fos4Threshold, fos5Threshold, fos20Threshold, outDir )
    my_struct(1).BWPicFullPath = [];
    my_struct(1).BWPicFullPath2 = [];
    my_struct(1).BWPicFullPath3 = [];
    for i = 1:length(my_struct)
%         disp(my_struct(i));
        splitFileName = split(my_struct(i).fullPath,'\');
        fileNameWithExtention = splitFileName{length(splitFileName)};
%         fileName =  fileNameWithExtention(1:(length(fileNameWithExtention)-1-length(my_struct(i).picType)));
        if my_struct(i).isDAPI == 1 && my_struct(i).magnification == 4 && dapi4Threshold ~= 0
            BWImage = getContrastOfImageTest1(my_struct(i).fullPath, dapi4Threshold, 10000);
        elseif my_struct(i).isDAPI == 1 && my_struct(i).magnification == 20 && dapi20Threshold ~= 0
            BWImage = getContrastOfImageTest1(my_struct(i).fullPath, dapi20Threshold, 200);
        elseif my_struct(i).isFos == 1 && my_struct(i).magnification == 4 && fos4Threshold ~= 0
            BWImage = getContrastOfImageTest1(my_struct(i).fullPath, fos4Threshold, 10000);
        elseif my_struct(i).isFos == 1 && my_struct(i).magnification == 20 && fos20Threshold ~= 0
            BWImage = getContrastOfImageTest1(my_struct(i).fullPath, fos20Threshold, 40);
        elseif my_struct(i).isFos == 1 && my_struct(i).magnification == 5 && fos5Threshold ~= 0
            BWImage = getContrastOfImageTest1(my_struct(i).fullPath, fos5Threshold, 10000);
        elseif my_struct(i).isDAPI == 1 && my_struct(i).magnification == 5 && dapi5Threshold ~= 0
            BWImage = getContrastOfImageTest1(my_struct(i).fullPath, dapi5Threshold, 10000);
        end
        if exist('BWImage')
            path = [outDir, '\BW_', fileNameWithExtention];
            imwrite(BWImage, path,'tif');
            if isempty(my_struct(i).BWPicFullPath)
                my_struct(i).BWPicFullPath = path;
            elseif isempty(my_struct(i).BWPicFullPath2)
                my_struct(i).BWPicFullPath2 = path;
            else
                my_struct(i).BWPicFullPath3 = path;
            end
            clear('BWImage');
        end
    end
    save('my_struct');
end