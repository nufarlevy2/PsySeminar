function [ image, imageTitle ] = getCellCountImage( currFile, thresholds )
    fos20Min=thresholds(1); fos20Max=thresholds(2); fos4Min=thresholds(3); fos4Max=thresholds(4); dapi20Min=thresholds(5); dapi20Max=thresholds(6); dapi4Min=thresholds(7); dapi4Max=thresholds(8);
    fos20Contrast = 0.04;
    dapi4Contrast = 0.03;
    dapi20Contrast = 0.02;
    currPath = currFile.fullPath;
    if currFile.isFos && currFile.magnification == 20
        I = getContrastOfImage(currPath, fos20Contrast);
        count = getNumOfCellsFromImage(currPath, I, fos20Contrast, fos20Min, fos20Max, currPath, currPath);
    elseif currFile.isDAPI && currFile.magnification == 4
        I = getContrastOfImage(currPath, dapi4Contrast);
        count = getNumOfCellsFromImage(currPath, I, dapi4Contrast, dapi4Min, dapi4Max, currPath, currPath);
    elseif currFile.isDAPI && currFile.magnification == 20
        I = getContrastOfImage(currPath, dapi20Contrast);
        count = getNumOfCellsFromImage(currPath, I, dapi20Contrast, dapi20Min, dapi20Max, currPath, currPath);
    end
    if count >= 0
        resultPath = [currPath, '_algoritemResult.tif'];
        image = imread(resultPath);
        splitedName = split(currFile.name, '\');
        imageTitle = sprintf('Image: %s, Rat Num: %d, Section: %s, Date: %s, Cell Count: %d', replace(splitedName{length(splitedName)}, '_','\_'), currFile.RatNum, currFile.Section, currFile.Date, count);
    end
end

