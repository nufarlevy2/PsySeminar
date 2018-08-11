function [ currFile, centers, radiuses ] = getCellCountImageForExcel( currFile, thresholds, initialThreshold, thresholdJump, rows)
    currPath = currFile.fullPath;
    index = 1;
    for inti = 1:length(rows)
        if ~strcmp(rows{inti},'Other')
            stainingsFromTableRows{index} = regexp(rows{inti},'(\D+)','match');
            magnificationFromTableRows{index} = regexp(rows{inti},'(\d+)','match');
            magnificationFromTableRows{index} = str2num(cell2mat(magnificationFromTableRows{index}));
            index = index + 1;
        end
    end
    I = getContrastOfImage(currPath, initialThreshold);
    if sum(find(strcmp([stainingsFromTableRows{:}],currFile.staining))) > 0 && sum(find([magnificationFromTableRows{:}] == currFile.magnification)) > 0 && (find(strcmp(rows,[currFile.staining,num2str(currFile.magnification)])) < size(thresholds,1))
        rowOfThresholds = thresholds(find(strcmp(rows,[currFile.staining,num2str(currFile.magnification)])),:);
        rowOfThresholds{1} = str2num(rowOfThresholds{1});
        rowOfThresholds{2} = str2num(rowOfThresholds{2});
    else
        rowOfThresholds{1} = [];
        rowOfThresholds{2} = [];
    end
    if isempty(rowOfThresholds{1}) || isempty(rowOfThresholds{2})
        if currFile.magnification < 10
            rowOfThresholds{1} = 4;
            rowOfThresholds{2} = 7;
        else
            rowOfThresholds{1} = 10;
            rowOfThresholds{2} = 45;
        end
    end
    currFile.Staining = currFile.staining;
    [count, centers, radiuses] = getNumOfCellsFromImage(currPath, I, initialThreshold, rowOfThresholds{1}, rowOfThresholds{2}, currPath, currPath, thresholdJump);
    splitedName = split(currFile.name, '\');
    currFile.Number_Of_Cells = count;
    currFile.File_Name = splitedName{length(splitedName)};
    currFile.Magnification = currFile.magnification;
    currFile = rmfield(currFile, {'picType','fullPath','isPic','datenum','isdir','bytes','date','folder','name', 'staining', 'magnification'});
    currFile = orderfields(currFile, {'File_Name', 'Section', 'RatNum', 'Date', 'Staining', 'Brain_Area', 'Magnification', 'Number_Of_Cells'});  
end