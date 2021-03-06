function [BWI] = getContrastOfImage(fullPath, threshold)
    I = imread(fullPath);
%     figure, imshow(I), title(['original image: ',fullPath]);
    BWI = im2bw(I, threshold);
%     figure, imshow(BWI), title('BW image');
%     [~, threshold] = edge(BWI, 'sobel');
%     BWs = edge(BWI,'sobel', threshold * fudgeFactor);
%     figure, imshow(BWs), title('binary gradient mask');
%     se90 = strel('line', 3, 90);
%     se0 = strel('line', 3, 0);
%     BWsdil = imdilate(BWs, [se90 se0]);
%     figure, imshow(BWsdil), title('dilated gradient mask');
%     BWdfill = imfill(BWsdil, 'holes');
%     figure, imshow(BWdfill);
%     title('binary image with filled holes');
%     BWnobord = imclearborder(BWdfill, 4);
%     figure, imshow(BWnobord), title('cleared border image');
%     seD = strel('diamond',1);
%     BWfinal = imerode(BWnobord,seD);
%     BWfinal = imerode(BWfinal,seD);
%     figure, imshow(BWfinal), title('segmented image');
%     BWoutline = bwperim(BWfinal);
%     Segout = BWI; 
%     Segout(BWoutline) = 255; 
%     figure, imshow(Segout), title('outlined original image');
end

