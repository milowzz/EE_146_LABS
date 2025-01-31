clc;
clear all;
close all;

% Load the image
image = imread('coins.png');

% Convert to grayscale if the image is RGB
if size(image, 3) == 3
    grayImage = rgb2gray(image);
else
    grayImage = image;
end

% Convert the grayscale image to a binary image
binaryImage = imbinarize(grayImage);

% Create a disk-shaped structuring element with radius 5
se = strel('disk', 5);
se_pt2 = strel('diamond', 10);
se_pt3 = strel('cube', 15);

% Perform morphological CLOSING
dilateImg = imdilate(binaryImage, se);
erodedImg = imerode(binaryImage, se);
 openImg  = imopen(binaryImage,se);
closeImg = imclose(binaryImage, se);

dilateImg_pt2= imdilate(binaryImage, se_pt2);
erodedImg_pt2= imerode(binaryImage, se_pt2);
 openImg_pt2 = imopen(binaryImage,se_pt2);
closeImg_pt2 = imclose(binaryImage, se_pt2);

dilateImg_pt3= imdilate(binaryImage, se_pt3);
erodedImg_pt3= imerode(binaryImage, se_pt3);
 openImg_pt3 = imopen(binaryImage,se_pt3);
closeImg_pt3 = imclose(binaryImage, se_pt3);



% Display the result
figure;

%disk size 5
subplot(3, 4, 1);
imshow(dilateImg);
title('Morphological Dilate', 'FontSize', 6);

subplot(3, 4, 2);
imshow(erodedImg);
title('Morphological Erode', 'FontSize', 6);

subplot(3, 4, 3);
imshow(openImg);
title('Morphological Opening', 'FontSize', 6);

subplot(3, 4, 4);
imshow(closeImg);
title('Morphological Closing', 'FontSize', 6);

%diamond size 10
subplot(3, 4, 5);
imshow(dilateImg_pt2);
title('Morphological Dilate', 'FontSize', 6);

subplot(3, 4, 6);
imshow(erodedImg_pt2);
title('Morphological Erode', 'FontSize', 6);

subplot(3, 4, 7);
imshow(openImg_pt2);
title('Morphological opening', 'FontSize', 6);

subplot(3, 4, 8);
imshow(closeImg_pt2);
title('Morphological closing', 'FontSize', 6);

%cube size 15 
subplot(3, 4, 9);
imshow(dilateImg_pt3);
title('Morphological Dilate', 'FontSize', 6);

subplot(3, 4, 10);
imshow(erodedImg_pt3);
title('Morphological Erode', 'FontSize', 6);

subplot(3, 4, 11);
imshow(openImg_pt3);
title('Morphological opening', 'FontSize', 6);

subplot(3, 4, 12);
imshow(closeImg_pt3);
title('Morphological closing', 'FontSize', 6);



ex_1 = [1 1 0 1 1 1 0 1;
       1 0 1 0 1 0 1 0;
       1 1 1 1 0 0 0 1;
       0 0 0 0 0 0 0 1;
       1 1 1 1 0 1 0 1;
       0 0 0 1 0 1 0 1;
       1 1 0 1 0 0 0 1;
       1 1 0 1 0 1 1 1];

ex_2 =[0 0 1 0 0 1 1 1;
      0 1 1 1 1 1 1 1;
      1 1 1 1 1 1 1 1;
      1 1 1 1 1 1 1 1;
      1 1 1 0 0 1 1 1;
      1 1 1 0 0 0 0 0;
      1 1 1 0 0 1 1 1;
      1 1 1 0 0 1 1 1];

%using our own algorithim
Custom_Im1 = connectedComponents4(ex_1); 
Custom_Im2 = connectedComponents4(ex_2);

%comparing to matlab's bulit in algorthim 
RealImg_matlab1 = bwconncomp(ex_1,4);
RealImg_matlab2 = bwconncomp(ex_2,4);

fprintf('<strong>---Image Statistics using matlabs conncomp ---</strong>\n');
Realstats1 = regionprops(RealImg_matlab1, 'Area', 'Centroid', 'Perimeter', 'Circularity');
Realstats1

Realstats2 = regionprops(RealImg_matlab2, 'Area', 'Centroid', 'Perimeter', 'Circularity');
Realstats2

fprintf('<strong>--- Our image algorithim statistics ---</strong>\n');

stats1 = regionprops(Custom_Im1, 'Area', 'Centroid', 'Perimeter','Circularity');
stats1

stats2 = regionprops(Custom_Im2, 'Area', 'Centroid', 'Perimeter','Circularity');
stats2

function labeledImage = connectedComponents4(binaryImage)
    [rows, cols] = size(binaryImage);
    label = 2; % Start labeling from 2 (background = 0, foreground = 1)
    labeledImage = zeros(rows, cols); % Initialize output labeled image
    equivalence = containers.Map('KeyType', 'double', 'ValueType', 'double'); % Store equivalence relationships

    % First pass: Assign initial labels
    for r = 1:rows
        for c = 1:cols
            if binaryImage(r, c) == 1 % Process foreground pixels
                neighbors = get_neighbors(labeledImage, r, c);
                if isempty(neighbors)
                    labeledImage(r, c) = label;
                    equivalence(label) = label; % Each label points to itself initially
                    label = label + 1;
                else
                    min_label = min(neighbors);
                    labeledImage(r, c) = min_label;
                    % Register equivalences
                    for i = 1:length(neighbors)
                        union_labels(equivalence, neighbors(i), min_label);
                    end
                end
            end
        end
    end


% Second pass: Resolve equivalences and relabel
for r = 1:rows
    for c = 1:cols
        if labeledImage(r, c) > 0
            labeledImage(r, c) = find_representative(equivalence, labeledImage(r, c));
        end
    end
end
end 


function neighbors = get_neighbors(labels, r, c)
    % Get the 4-connected neighbors of a pixel
    neighbors = [];
    if r > 1 && labels(r-1, c) > 0 % Top neighbor
        neighbors = [neighbors, labels(r-1, c)];
    end
    if c > 1 && labels(r, c-1) > 0 % Left neighbor
        neighbors = [neighbors, labels(r, c-1)];
    end
end

function union_labels(equivalence, label1, label2)
    % Merge equivalence classes
    root1 = find_representative(equivalence, label1);
    root2 = find_representative(equivalence, label2);
    if root1 ~= root2
        % Map the larger root to the smaller root
        if root1 < root2
            equivalence(root2) = root1;
        else
            equivalence(root1) = root2;
        end
    end
end

function representative = find_representative(equivalence, label)
    % Find the representative label using path compression
    while label ~= equivalence(label)
        equivalence(label) = equivalence(equivalence(label)); % Path compression
        label = equivalence(label);
    end
    representative = label;
end


