function [ structToExcel ] = countOverlapCircles( objects, structToExcel, thresholds )
    objects = findFilesWithSameParameters(objects, structToExcel);
    matchIndexInExcel = 1;
    for index = 1:size(objects, 2)
        if ~isempty(objects(index).indexesOfSamePics)
            matchesIndexes = objects(index).indexesOfSamePics;
            for subIndex = 1:length(objects(index).indexesOfSamePics)
                count = 0;
                for inti = 1:length(objects(index).Radiuses)
                    foundOverlap = false;
                    for intj = 1:length(objects(matchesIndexes(subIndex)).Radiuses)
                        overlap = area_intersect_circle_analytical([[objects(index).Centers(inti,:),objects(index).Radiuses(inti)];[objects(matchesIndexes(subIndex)).Centers(intj,:),objects(matchesIndexes(subIndex)).Radiuses(intj)]]);
                        if overlap(2,1) > 0 && inti ~= intj
                            foundOverlap = true;
                            break;
                        end
                    end
                    if foundOverlap
                        count = count + 1;
                        break;
                    end
                end
                if count > 0
                    newField = ['Overlap_Cells_Image_Match_Num_',num2str(matchIndexInExcel)];
                    structToExcel(index).(newField) = objects(matchesIndexes(subIndex)).File_Name;
                    newField = ['Num_Of_Overlap_Cells_Match_Num_',num2str(matchIndexInExcel)];
                    structToExcel(index).(newField) = count;
                    matchIndexInExcel = matchIndexInExcel + 1;
                end
            end
        end
    end
end

