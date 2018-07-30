function [ result ] = getNumOfCellsFromImage( pathOfCircledOutImage, I, contrastThreshold, minThreshold, maxThreshold, pathOfResultedImage, originImagePath )
    
    dapi4mag80accuracy = 0.04;
    dapi5mag80accuracy = 0.04;
    dapi20mag80accuracy = 0.07;
    fos4mag80accuracy = 0.05;
    fos5mag80accuracy = 0.09;
    fos20mag80accuracy = 0.18;
    
%     I = getContrastOfImage(pathOfCircledOutImage, contrastThreshold);
%    I = imread(pathOfCircledOutImage);
%     figure, imshow(I), title([pathOfCircledOutImage((length(pathOfCircledOutImage)-30):length(pathOfCircledOutImage)), ', contrast: ',num2str(contrastThreshold)]);
    stats = regionprops('table',I,'Centroid','MajorAxisLength','MinorAxisLength');
    centers = stats.Centroid;
    diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
    radii = diameters/2;
    relevantCenters = centers(radii > minThreshold & radii < maxThreshold, :);
    relevantRadius = radii(radii > minThreshold & radii < maxThreshold, :);
%     hold on;
%     viscircles(relevantCenters, relevantRadius);
    needToContinue = relevantRadius(relevantRadius >= minThreshold);
    count = 0;
    countIndexes = [];
    index = 1;
    for inti = 1:length(relevantRadius)
        if relevantRadius(inti) >= minThreshold && relevantRadius(inti) <= minThreshold+20
            foundOverlap = false;
            for intj = 1:length(relevantRadius)
                overlap = area_intersect_circle_analytical([[relevantCenters(inti,:),relevantRadius(inti)];[relevantCenters(intj,:),relevantRadius(intj)]]);
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
    RGBImage = imread(pathOfCircledOutImage);
    resultImage = imread(pathOfResultedImage);
    imwrite(resultImage, 'resultImage.tif',  'tif', 'WriteMode', 'overwrite');
    imwrite(RGBImage, 'tmpImage.tif','tif', 'WriteMode', 'overwrite');
    if count > 0
        relevantCentersToBeColored = relevantCenters(countIndexes,:);
        relevantRadiusesToBeColored = relevantRadius(countIndexes);
%         resultImage = viscircles(relevantCentersToBeColored, relevantRadiusesToBeColored, 'Color', 'Black');
        for circleIndex = 1:length(relevantRadiusesToBeColored)
            resultImage = imread('resultImage.tif');
            resultImage = insertShape(resultImage,'Circle',[relevantCentersToBeColored(circleIndex,1) ...
                relevantCentersToBeColored(circleIndex,2) relevantRadiusesToBeColored(circleIndex)], 'Color', 'White', 'LineWidth' , 3);
            imwrite(resultImage, 'resultImage.tif', 'tif', 'WriteMode', 'overwrite');
            I = imread('tmpImage.tif');
            I = insertShape(I,'FilledCircle',[relevantCentersToBeColored(circleIndex,1) ...
                relevantCentersToBeColored(circleIndex,2) relevantRadiusesToBeColored(circleIndex)], 'Color', 'Black');
            imwrite(I, 'tmpImage.tif','tif', 'WriteMode', 'overwrite');
        end
%         figure, imshow(I);
    end
    if ~isempty(needToContinue)
        count = getNumOfCellsFromImage('tmpImage.tif', getContrastOfImage('tmpImage.tif',contrastThreshold + 0.03) , contrastThreshold + 0.03, minThreshold, maxThreshold, 'resultImage.tif', originImagePath) + count;
    end
    if strcmp(originImagePath, pathOfCircledOutImage)
        newPathOfResultedImage = [originImagePath,'_algoritemResult.tif'];
        resultImage = imread('resultImage.tif');
        imwrite(resultImage, newPathOfResultedImage, 'tif');
        delete tmpImage.tif resultImage.tif
    end
    result = count;
end

