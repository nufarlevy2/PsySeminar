function [ result ] = getNumOfCellsFromImage( pathOfImage, contrastThreshold, minThreshold, maxThreshold )
    
    dapi4mag80accuracy = 0.04;
    dapi5mag80accuracy = 0.04;
    dapi20mag80accuracy = 0.07;
    fos4mag80accuracy = 0.05;
    fos5mag80accuracy = 0.09;
    fos20mag80accuracy = 0.18;
    
    I = getContrastOfImage(pathOfImage, contrastThreshold);
%    I = imread(pathOfImage);
    figure, imshow(I), title([pathOfImage((length(pathOfImage)-30):length(pathOfImage)), ', contrast: ',num2str(contrastThreshold)]);
    stats = regionprops('table',I,'Centroid','MajorAxisLength','MinorAxisLength');
    centers = stats.Centroid;
    diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
    radii = diameters/2;
    relevantCenters = centers(radii > minThreshold & radii < maxThreshold, :);
    relevantRadius = radii(radii > minThreshold & radii < maxThreshold, :);
    hold on;
    viscircles(relevantCenters, relevantRadius);
    needToContinue = relevantRadius(relevantRadius >= minThreshold);
    count = 0;
    countIndexes = [];
    index = 1;
    for inti = 1:length(relevantRadius)
        if relevantRadius(inti) >= minThreshold && relevantRadius(inti) <= minThreshold+15
            foundOverlap = false;
            for intj = 1:length(relevantRadius)
                overlap = area_intersect_circle_analytical([[relevantCenters(inti,:),relevantRadius(inti)];[relevantCenters(intj,:),relevantRadius(intj)]]);
                disp(overlap);
                if overlap(1,1) == overlap(1,2) && inti ~= intj
                    foundOverlap = true;
                    break;
                end
            end
            if ~foundOverlap
                count = count + 1;
                countIndexes(index) = inti;
                index = index + 1;                
            end
        end
    end
    if ~isempty(needToContinue)
        getNumOfCellsFromImage(pathOfImage, contrastThreshold + 0.03, minThreshold, maxThreshold);
    end  
end

