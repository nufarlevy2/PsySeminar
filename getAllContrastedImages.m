function [ output_args ] = getAllContrastedImages( my_struct, dapi4Threshold, dapi5Threshold, dapi20Threshold, fos4Threshold, fos5Threshold, fos20Threshold, outDir )
    my_struct(1).BWPicFullPath = [];
    my_struct(1).BWPicFullPath2 = [];
    my_struct(1).BWPicFullPath3 = [];
    for i = 1:length(my_struct)
%         disp(my_struct(i));
        splitFileName = split(my_struct(i).fullPath,'\');
        fileNameWithExtention = splitFileName{length(splitFileName)};
%         fileName =  fileNameWithExtention(1:(length(fileNameWithExtention)-1-length(my_struct(i).picType)));
        if strcmp('DAPI',my_struct(i).staining) && my_struct(i).magnification == 4 && dapi4Threshold ~= 0
            BWImage = getContrastOfImage(my_struct(i).fullPath, dapi4Threshold);
        elseif strcmp('DAPI',my_struct(i).staining) && my_struct(i).magnification == 20 && dapi20Threshold ~= 0
            BWImage = getContrastOfImage(my_struct(i).fullPath, dapi20Threshold);
        elseif strcmp('Fos',my_struct(i).staining) && my_struct(i).magnification == 4 && fos4Threshold ~= 0
            BWImage = getContrastOfImage(my_struct(i).fullPath, fos4Threshold);
        elseif strcmp('Fos',my_struct(i).staining) && my_struct(i).magnification == 20 && fos20Threshold ~= 0
            BWImage = getContrastOfImage(my_struct(i).fullPath, fos20Threshold);
        elseif strcmp('Fos',my_struct(i).staining) && my_struct(i).magnification == 5 && fos5Threshold ~= 0
            BWImage = getContrastOfImage(my_struct(i).fullPath, fos5Threshold);
        elseif strcmp('DAPI',my_struct(i).staining) && my_struct(i).magnification == 5 && dapi5Threshold ~= 0
            BWImage = getContrastOfImage(my_struct(i).fullPath, dapi5Threshold);
        else
            BWImage = getContrastOfImage(my_struct(i).fullPath, 0.09);
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

