function [names] = getImageList(images, section, retNum, date, mag, staining)
    index = 2;
    names = {'All'};
    for intI = 1:length(images)
        if ((isempty(retNum) || strcmp('All', retNum) || images(intI).RatNum == str2double(retNum{1})) && ...
                (isempty(section) || strcmp('All', section) || strcmp(images(intI).Section, section)) && ...
                (isempty(date) || strcmp('All', date) || strcmp(images(intI).Date, date)) && ...
                (isempty(mag) || strcmp('All', mag) || images(intI).magnification == str2double(mag{1})) && ...
                (isempty(staining) || strcmp('All', staining) || strcmp(images(intI).staining, staining)))
            names{index} = images(intI).name;
            index = index + 1;
        end
    end
    objectsExist = exist('names', 'var');
    if ~objectsExist
        names = {''};
    end    
end


