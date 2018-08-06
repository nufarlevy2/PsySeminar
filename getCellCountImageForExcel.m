function [ currFile, centers, radiuses ] = getCellCountImageForExcel( currFile, thresholds, initialThreshold, thresholdJump)
    fos20Min=thresholds(1); fos20Max=thresholds(2); dapi20Min=thresholds(3); dapi20Max=thresholds(4); dapi4Min=thresholds(5); dapi4Max=thresholds(6); otherMin=thresholds(7); otherMax=thresholds(8);
    currPath = currFile.fullPath;
    if currFile.isFos && currFile.magnification == 20
        currFile.Staining = 'Fos';
        I = getContrastOfImage(currPath, initialThreshold);
        [count, centers, radiuses] = getNumOfCellsFromImage(currPath, I, initialThreshold, fos20Min, fos20Max, currPath, currPath, thresholdJump);
    elseif currFile.isDAPI && currFile.magnification == 4
        currFile.Staining = 'DAPI';
        I = getContrastOfImage(currPath, initialThreshold);
        [count, centers, radiuses] = getNumOfCellsFromImage(currPath, I, initialThreshold, dapi4Min, dapi4Max, currPath, currPath, thresholdJump);
    elseif currFile.isDAPI && currFile.magnification == 20
        currFile.Staining = 'DAPI';
        I = getContrastOfImage(currPath, initialThreshold);
        [count, centers, radiuses] = getNumOfCellsFromImage(currPath, I, initialThreshold, dapi20Min, dapi20Max, currPath, currPath, thresholdJump);
    else
        I = getContrastOfImage(currPath, initialThreshold);
        [count, centers, radiuses] = getNumOfCellsFromImage(currPath, I, initialThreshold, otherMin, otherMax, currPath, currPath, thresholdJump);
        currFile.Staining = "Unknown";
    end
    splitedName = split(currFile.name, '\');
    currFile.Number_Of_Cells = count;
    currFile.File_Name = splitedName{length(splitedName)};
    currFile.Magnification = currFile.magnification;
    currFile = rmfield(currFile, {'picType','fullPath','isFos','isDAPI','isPic','datenum','isdir','bytes','date','folder','name', 'staining', 'magnification'});
    currFile = orderfields(currFile, {'File_Name', 'Section', 'RatNum', 'Date', 'Staining', 'Brain_Area', 'Magnification', 'Number_Of_Cells'});  
end