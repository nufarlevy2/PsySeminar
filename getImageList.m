function [names] = getImageList(images, section, retNum, date)
    index = 2;
    names = {'All'};
    for intI = 1:length(images)
        if ((isempty(retNum) || strcmp('All', retNum) || images(intI).RatNum == str2double(retNum{1})) && ...
                (isempty(section) || strcmp('All', section) || strcmp(images(intI).Section, section)) && ...
                (isempty(date) || strcmp('All', date) || strcmp(images(intI).Date, date)))
            names{index} = images(intI).name;
            index = index + 1;
        end
    end
end


