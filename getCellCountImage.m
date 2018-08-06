function [ image, imageTitle ] = getCellCountImage( currFile, thresholds, initialThreshold, thresholdJump)
    fos20Min=thresholds(1); fos20Max=thresholds(2); dapi20Min=thresholds(3); dapi20Max=thresholds(4); dapi4Min=thresholds(5); dapi4Max=thresholds(6); otherMin=thresholds(7); otherMax=thresholds(8);
    currPath = currFile.fullPath;
    if currFile.isFos && currFile.magnification == 20
        I = getContrastOfImage(currPath, initialThreshold);
        count = getNumOfCellsFromImage(currPath, I, initialThreshold, fos20Min, fos20Max, currPath, currPath, thresholdJump);
    elseif currFile.isDAPI && currFile.magnification == 4
        I = getContrastOfImage(currPath, initialThreshold);
        count = getNumOfCellsFromImage(currPath, I, initialThreshold, dapi4Min, dapi4Max, currPath, currPath, thresholdJump);
    elseif currFile.isDAPI && currFile.magnification == 20
        I = getContrastOfImage(currPath, initialThreshold);
        count = getNumOfCellsFromImage(currPath, I, initialThreshold, dapi20Min, dapi20Max, currPath, currPath, thresholdJump);
    else
        I = getContrastOfImage(currPath, initialThreshold);
        count = getNumOfCellsFromImage(currPath, I, initialThreshold, otherMin, otherMax, currPath, currPath, thresholdJump);
    end
    if count >= 0
        resultPath = [currPath, '_algoritemResult.tif'];
        image = imread(resultPath);
        splitedName = split(currFile.name, '\');
        imageTitle = sprintf('Image: %s, Rat Num: %d, Section: %s, Date: %s, Cell Count: %d', replace(splitedName{length(splitedName)}, '_','\_'), currFile.RatNum, currFile.Section, currFile.Date, count);
    end
end

