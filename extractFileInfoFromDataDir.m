function [ structFile ] = extractFileInfoFromDataDir(path)
    recDirStruct = dir2(path,'-r');
    sizeOfSruct = length(recDirStruct);
    for i = 1:sizeOfSruct
        name = split(recDirStruct(i).name,'\');
        for j = 1:length(name)
            ifNumOfHulda = regexp(name{j},'^\d+\.\d+$','match');
            isDate = regexp(name{j},'^\d{2}\.\d{2}\.\d{2}$','match');
            if contains(name{j}, 'Sec', 'IgnoreCase', true)
                numOfSec = split(name{j}, ' ');
                if isstrprop(numOfSec{end},'digit')
                    recDirStruct(i).Section = numOfSec{end};
                end
            elseif length(ifNumOfHulda) == 1
                tmp = split(ifNumOfHulda{1,1},'.');
                numOfHulda = tmp{2};
                recDirStruct(i).RatNum = numOfHulda;
            elseif length(isDate) == 1
                date = isDate{1,1};
                recDirStruct(i).Date = date;
            end
        end
    end
    structFile = recDirStruct;
end

