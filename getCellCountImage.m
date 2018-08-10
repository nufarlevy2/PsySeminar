function [ image, imageTitle ] = getCellCountImage( currFile, thresholds, initialThreshold, thresholdJump, rows)
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
    if sum(find(strcmp([stainingsFromTableRows{:}],currFile.staining))) > 0 && sum(find([magnificationFromTableRows{:}] == currFile.magnification)) > 0 && (length(thresholds(:,1)) >= length(rows))
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
    count = getNumOfCellsFromImage(currPath, I, initialThreshold, rowOfThresholds{1} , rowOfThresholds{2}, currPath, currPath, thresholdJump);
    if count >= 0
        resultPath = [currPath, '_algoritemResult.tif'];
        image = imread(resultPath);
        splitedName = split(currFile.name, '\');
        imageTitle = sprintf('Image: %s, Rat Num: %d, Section: %s, Date: %s, Cell Count: %d', replace(splitedName{length(splitedName)}, '_','\_'), currFile.RatNum, currFile.Section, currFile.Date, count);
    end
end

