function [ structToExcel ] = countOverlapCircles( objects, structToExcel, thresholds )
    objects = findFilesWithSameParameters(objects, structToExcel);
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
                newField = ['Overlap_Cells_With_Image_Num_',num2str(objects(index).indexesOfSamePics(subIndex))];
                structToExcel(index).(newField) = count;
            end
        end
    end
end

