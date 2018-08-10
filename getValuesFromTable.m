function [thresholds] = getValuesFromTable( tableOfThresholds )
    index = 1;
    for rowNum = 1:size(tableOfThresholds,1)
        if isempty(tableOfThresholds{rowNum,1}) thresholds(index) = 0; else fos20Min=str2num(tableOfThresholds{rowNum,1}); end
        if isempty(tableOfThresholds{rowNum,2}) thresholds(index+1) = 0; else fos20Min=str2num(tableOfThresholds{rowNum,2}); end
        index = index + 2;
    end
end
