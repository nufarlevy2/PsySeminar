function [ structFile ] = extractFileInfoFromDataDir(path)
    recDirStruct = dir2(path,'-r');
    sizeOfSruct = length(recDirStruct);
    index = 1;
%     if ~isempty(recDirStruct) && ismember('datenum',fieldnames(recDirStruct)) && ismember('isdir',fieldnames(recDirStruct))
%         rmfield(recDirStruct, 'datenum');
%         rmfield(recDirStruct, 'isdir');
%     end
    for i = 1:sizeOfSruct
        name = split(recDirStruct(i).name,'\');
        recDirStruct(i).isPic = 0;
        recDirStruct(i).Date = 0;
        recDirStruct(i).RatNum = 0;
        recDirStruct(i).magnification = 0;
        recDirStruct(i).fullPath = [];
        for j = 1:length(name)
            ifNumOfHulda = regexp(name{j},'^\d+\.\d+$','match');
            isDate = regexp(name{j},'^(\d{1}|\d{2})\.(\d{1}|\d{2})\.\d{2}$','match');
            isPic = regexp(name{j},'^\d{2}\.\d+([A-Z]|[a-z]|[0-9])*_\d+\s{1}((\w+|\w+\.\d+|\w+\-\w+)\s)+\d+x\.\w+$','match');
            if contains(name{j}, 'Sec', 'IgnoreCase', true)
                numOfSec = split(name{j}, ' ');
                if isstrprop(numOfSec{end},'digit')
                    recDirStruct(i).Section = numOfSec{end};
                end
            elseif length(ifNumOfHulda) == 1
                tmp = split(ifNumOfHulda{1,1},'.');
                numOfHulda = tmp{2};
                recDirStruct(i).RatNum = str2double(numOfHulda);
            elseif length(isDate) == 1
                date = isDate{1,1};
                recDirStruct(i).Date = date;
            elseif length(isPic) == 1
                splitedName = split(name{j}, ' ');
                recDirStruct(i).isPic = 1;
                isStaining = regexp(name{j},'^\d{2}\.\d+([A-Z]|[a-z]|[0-9])*_\d+\s{1}((\w+|\w+\.\d+|\w+\-\w+)\s){1}\w+\s{1}\d+x\.\w+$','match');
                if length(isStaining) == 1
                    recDirStruct(i).staining = splitedName{length(splitedName)-1};
                else
                    recDirStruct(i).staining = 'UNKNOWN';
                end
                magnification = regexp(regexp(name{j},'\d+x\.\w+$','match'), '\d+','match');
                picType = regexp(name{j},'\w+$','match');
                recDirStruct(i).magnification = str2double(magnification{1});
                recDirStruct(i).picType = picType{1};
                recDirStruct(i).fullPath = [recDirStruct(i).folder, '\', isPic{1}];
                splitedName = split(name{j}, ' ');
                if length(splitedName) > 2
                    recDirStruct(i).Brain_Area = splitedName{2};
                end
            end
        end
        if recDirStruct(i).isPic == 1
            structFile(index) = recDirStruct(i);
            index = index + 1;
        end
    end
end

