function [names] = getRatNumList(images, sections, retNums, dates)
    index = 1;
    names = {};
    for intI = 1:length(images)
        if (((isempty(retNums) || ~ismember(images(intI).retNum, retNums)) || ...
                (isempty(sections) || ~ismember(images(intI).Section, sections)) || ...
                (isempty(dates) || ~ismember(images(intI).Date, dates))) && ...
                ~ismember(num2str(images(intI).RatNum), names)) 
            names{index} = num2str(images(intI).RatNum);
            index = index + 1;
        end
    end
end


