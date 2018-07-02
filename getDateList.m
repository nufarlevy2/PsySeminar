function [names] = getDateList(images, section, retNum, date)
    index = 2;
    names = {'All'};
    for intI = 1:length(images)
        if (((isempty(retNum) || strcmp('All', retNum) || images(intI).RatNum == str2double(retNum{1})) && ...
                (isempty(section) || strcmp('All', section) || strcmp(images(intI).Section, section)) && ...
                (isempty(date) || strcmp('All', date) || strcmp(images(intI).Date, date))) && ...
                ~ismember(images(intI).Date, names)) 
            names{index} = images(intI).Date;
            index = index + 1;
        end
    end
end


