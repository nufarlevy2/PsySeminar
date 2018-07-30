function [result] = runGetNumOfCellsForAllFosImages(fos20MinThreshold, fos20MaxThreshold, fos20Contrast, dapi4MinThreshold, dapi4MaxThreshold, dapi4Contrast, dapi20MinThreshold, dapi20MaxThreshold, dapi20Contrast)
    allFiles = extractFileInfoFromDataDir('C:\Users\levyn\Desktop\study\psySeminar\data\');
    for fileIndex = 1:length(allFiles)
        currFile = allFiles(fileIndex);
        currPath = currFile.fullPath;
        if currFile.isFos && currFile.magnification == 20
            I = getContrastOfImage(currPath, fos20Contrast);
            allFiles(fileIndex).Num_Of_Cells = getNumOfCellsFromImage(currPath, I, fos20Contrast, fos20MinThreshold, fos20MaxThreshold, currPath, currPath);
        elseif currFile.isDAPI && currFile.magnification == 4
            I = getContrastOfImage(currPath, dapi4Contrast);
            allFiles(fileIndex).Num_Of_Cells = getNumOfCellsFromImage(currPath, I, dapi4Contrast, dapi4MinThreshold, dapi4MaxThreshold, currPath, currPath);
        elseif currFile.isDAPI && currFile.magnification == 20
            I = getContrastOfImage(currPath, dapi20Contrast);
            allFiles(fileIndex).Num_Of_Cells = getNumOfCellsFromImage(currPath, I, dapi20Contrast, dapi20MinThreshold, dapi20MaxThreshold, currPath, currPath);
        end
    end
    result = allFiles;
end