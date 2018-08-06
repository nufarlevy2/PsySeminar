function [ objects ] = findFilesWithSameParameters( objects, structToExcel )
    for ii = 1:size(objects,2)
        objects(ii).sameParametersPics = {};
        objects(ii).indexesOfSamePics = [];
        samePicIndex = 1;
        for jj = 1:size(objects,2)
            if ii ~= jj && strcmp(structToExcel(ii).Section, structToExcel(jj).Section) ...
                    && structToExcel(ii).RatNum == structToExcel(jj).RatNum ...
                    && strcmp(structToExcel(ii).Date, structToExcel(jj).Date) ...
                    && strcmp(structToExcel(ii).Brain_Area, structToExcel(jj).Brain_Area) ...
                    && structToExcel(ii).Magnification == structToExcel(jj).Magnification
                objects(ii).sameParametersPics{samePicIndex} = objects(jj).name;
                objects(ii).indexesOfSamePics(samePicIndex) = jj;
                samePicIndex = samePicIndex + 1;
            end
        end
    end
                
end

