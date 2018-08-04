function [ count ] = getNumOfCellsFromImage( pathOfCircledOutImage, I, contrastThreshold, minThreshold, maxThreshold, pathOfResultedImage, originImagePath )
    stats = regionprops('table',I,'Centroid','MajorAxisLength','MinorAxisLength');
    centers = stats.Centroid;
    diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
    radii = diameters/2;
    relevantCenters = centers(radii > minThreshold, :);
    relevantRadius = radii(radii > minThreshold, :);
    needToContinue = relevantRadius(relevantRadius >= minThreshold);
    count = 0;
    countIndexes = [];
    index = 1;
    for inti = 1:length(relevantRadius)
        if relevantRadius(inti) >= minThreshold && relevantRadius(inti) <= maxThreshold
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
    splitedPath = split(originImagePath,'\');
    nameOfPic = splitedPath{length(splitedPath)};
    imwrite(resultImage, [nameOfPic,'_resultImage.tif'],  'tif', 'WriteMode', 'overwrite');
    imwrite(RGBImage, [nameOfPic,'_tmpImage.tif'],'tif', 'WriteMode', 'overwrite');
    if count > 0
        relevantCentersToBeColored = relevantCenters(countIndexes,:);
        relevantRadiusesToBeColored = relevantRadius(countIndexes);
        I = imread([nameOfPic,'_tmpImage.tif']);
        resultImage = imread([nameOfPic,'_resultImage.tif']);
        for circleIndex = 1:length(relevantRadiusesToBeColored)
            resultImage = insertShape(resultImage,'Circle',[relevantCentersToBeColored(circleIndex,1) ...
                relevantCentersToBeColored(circleIndex,2) relevantRadiusesToBeColored(circleIndex)], 'Color', 'White', 'LineWidth' , 3);
            I = insertShape(I,'FilledCircle',[relevantCentersToBeColored(circleIndex,1) ...
                relevantCentersToBeColored(circleIndex,2) relevantRadiusesToBeColored(circleIndex)], 'Color', 'Black');
        end
        imwrite(resultImage, [nameOfPic,'_resultImage.tif'], 'tif', 'WriteMode', 'overwrite');
        imwrite(I, [nameOfPic,'_tmpImage.tif'],'tif', 'WriteMode', 'overwrite');
%         figure, imshow(I);
    end
    if ~isempty(needToContinue)
        count = getNumOfCellsFromImage([nameOfPic,'_tmpImage.tif'], getContrastOfImage([nameOfPic,'_tmpImage.tif'],contrastThreshold + 0.03) , contrastThreshold + 0.03, minThreshold, maxThreshold, [nameOfPic,'_resultImage.tif'], originImagePath) + count;
    end
    if strcmp(originImagePath, pathOfCircledOutImage)
        newPathOfResultedImage = [originImagePath,'_algoritemResult.tif'];
        resultImage = imread([nameOfPic,'_resultImage.tif']);
        imwrite(resultImage, newPathOfResultedImage, 'tif');
        delete([nameOfPic,'_tmpImage.tif']) 
        delete([nameOfPic,'_resultImage.tif']);
    end
end

