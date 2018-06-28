function [ structFile ] = extractFileInfoFromDataDir(path)
    recDirStruct = dir2(path,'-r');
    sizeOfSruct = length(recDirStruct);
    for i = 1:sizeOfSruct
        name = split(recDirStruct(i).name,'\');
        recDirStruct(i).isPic = 0;
        recDirStruct(i).isDAPI = 0;
        recDirStruct(i).isFos = 0;
        for j = 1:length(name)
            ifNumOfHulda = regexp(name{j},'^\d+\.\d+$','match');
            isDate = regexp(name{j},'^\d{2}\.\d{2}\.\d{2}$','match');
            isPic = regexp(name{j},'^\d{2}\.\d+([A-Z]|[a-z]|[0-9])*_\d+\s{1}((\w+|\w+\.\d+|\w+\-\w+)\s)+\d+x\.\w+$','match');
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
            elseif length(isPic) == 1
                recDirStruct(i).isPic = 1;
                isDAPI = regexp(name{j},'^\d{2}\.\d+([A-Z]|[a-z]|[0-9])*_\d+\s{1}((\w+|\w+\.\d+|\w+\-\w+)\s){1}DAPI\s{1}\d+x\.\w+$','match');
                isFos = regexp(name{j},'^\d{2}\.\d+([A-Z]|[a-z]|[0-9])*_\d+\s{1}((\w+|\w+\.\d+|\w+\-\w+)\s){1}Fos\s{1}\d+x\.\w+$','match');
                if length(isDAPI) == 1
                    recDirStruct(i).isDAPI = 1;
                elseif length(isFos) == 1
                    recDirStruct(i).isFos = 1;
                end
                magnification = regexp(regexp(name{j},'(\d+)x\.(\w+)$','match'), '\d+','match');
                picType = regexp(name{j},'\w+$','match');
                recDirStruct(i).magnification = magnification{1};
                recDirStruct(i).picType = picType{1};
                disp(recDirStruct(i).magnification);
                disp(recDirStruct(i).picType);
            end
        end
    end
    structFile = recDirStruct;
end
