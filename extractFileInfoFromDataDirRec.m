function [ structFile ] = extractFileInfoFromDataDir(path)
    recDirStruct = dir2(path,'-r');
    structFile = recDirStruct;
end

