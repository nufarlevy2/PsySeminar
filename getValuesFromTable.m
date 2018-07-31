function [thresholds] = getValuesFromTable( tableOfThresholds )
    if isempty(tableOfThresholds{1,1}) fos20Min=22; else fos20Min=str2num(tableOfThresholds{1,1}); end
    if isempty(tableOfThresholds{1,2}) fos20Max=45; else fos20Max=str2num(tableOfThresholds{1,2}); end
    if isempty(tableOfThresholds{2,1}) fos4Min=8; else fos4Min=str2num(tableOfThresholds{2,1}); end
    if isempty(tableOfThresholds{2,2}) fos4Max=10; else fos4Max=str2num(tableOfThresholds{2,2}); end
    if isempty(tableOfThresholds{3,1}) dapi20Min=22; else dapi20Min=str2num(tableOfThresholds{3,1}); end
    if isempty(tableOfThresholds{3,2}) dapi20Max=45; else dapi20Max=str2num(tableOfThresholds{3,2}); end
    if isempty(tableOfThresholds{4,1}) dapi4Min=8; else dapi4Min=str2num(tableOfThresholds{4,1}); end
    if isempty(tableOfThresholds{4,2}) dapi4Max=10; else dapi4Max=str2num(tableOfThresholds{4,2}); end
    thresholds = [fos20Min, fos20Max, fos4Min, fos4Max, dapi20Min, dapi20Max, dapi4Min, dapi4Max];
end
