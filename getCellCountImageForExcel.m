function [ currFile ] = getCellCountImageForExcel( currFile, thresholds )
    fos20Min=thresholds(1); fos20Max=thresholds(2); fos4Min=thresholds(3); fos4Max=thresholds(4); dapi20Min=thresholds(5); dapi20Max=thresholds(6); dapi4Min=thresholds(7); dapi4Max=thresholds(8);
    fos20Contrast = 0.04;
    fos4Constrast = 0.02;
    dapi4Contrast = 0.03;
    dapi20Contrast = 0.02;
    currPath = currFile.fullPath;
    count = -1;
    if currFile.isFos && currFile.magnification == 20
        currFile.Staining = 'Fos';
        I = getContrastOfImage(currPath, fos20Contrast);
        count = getNumOfCellsFromImage(currPath, I, fos20Contrast, fos20Min, fos20Max, currPath, currPath);
    elseif currFile.isDAPI && currFile.magnification == 4
        currFile.Staining = 'DAPI';
        I = getContrastOfImage(currPath, dapi4Contrast);
        count = getNumOfCellsFromImage(currPath, I, dapi4Contrast, dapi4Min, dapi4Max, currPath, currPath);
    elseif currFile.isDAPI && currFile.magnification == 20
        currFile.Staining = 'DAPI';
        I = getContrastOfImage(currPath, dapi20Contrast);
        count = getNumOfCellsFromImage(currPath, I, dapi20Contrast, dapi20Min, dapi20Max, currPath, currPath);
    elseif currFile.isFos && currFile.magnification == 4
        currFile.Staining = 'Fos';
        I = getContrastOfImage(currPath, fos4Constrast);
        count = getNumOfCellsFromImage(currPath, I, fos4Constrast, fos4Min, fos4Max, currPath, currPath);
    else
        currFile.Staining = "Unknown";
    end
    splitedName = split(currFile.name, '\');
    currFile.Number_Of_Cells = count;
    currFile.File_Name = splitedName{length(splitedName)};
    currFile.Magnification = currFile.magnification;
    currFile = rmfield(currFile, {'picType','fullPath','isFos','isDAPI','isPic','datenum','isdir','bytes','date','folder','name', 'staining', 'magnification'});
    currFile = orderfields(currFile, {'File_Name', 'Section', 'RatNum', 'Date', 'Staining', 'Staining_Sub_Type', 'Magnification', 'Number_Of_Cells'});  
end