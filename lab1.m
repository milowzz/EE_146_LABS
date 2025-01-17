% Read the RGB image
clc;
clear all;
close all;
rgbImage = imread("C:\Users\Milog\Downloads\fruit.png");

info = imfinfo("C:\Users\Milog\Downloads\fruit.png"); % Retrieve image file information
bytesPerPixel = info.BitDepth / 8; % Bits per pixel divided by 8 for bytes

% Convert to Grayscale
grayImage = im2gray(rgbImage);

% Calculate the mean value of grayscale image
meanVal = mean(grayImage, "all");


% Create a binary image based on the mean value
binaryImage = grayImage >= meanVal;

% Adjust intensity using imadjust
I_high = imadjust(grayImage, stretchlim(grayImage), [0, 1]);
I_low = imadjust(grayImage, [0.3, 0.7], [0.4, 0.6]);


% Display the number of rows, columns, and bytes per pixel in the Command Window
[rows, columns, channels] = size(rgbImage);


% Create a subplot layout for all images and histograms
subplot(3, 1, 1);
imshow(rgbImage);
title('RGB Image', 'FontSize', 8); % Smaller font size
text(10, 1000, sprintf('Rows: %d, Cols: %d, Bytes/Pixel: %d', rows, columns, bytesPerPixel), ...
    'FontSize', 7, 'Color', 'yellow', 'BackgroundColor', 'black');

subplot(3, 1, 2);
imshow(grayImage);
title('Grayscale Image', 'FontSize', 8);

subplot(3, 1, 3);
imshow(binaryImage);
title('Binary Image', 'FontSize', 8);




%% 

subplot(2, 2, 1);
imshow(I_high);
title('I\_high', 'FontSize', 8);

subplot(2, 2, 2);
imshow(I_low);
title('I\_low', 'FontSize', 8);

subplot(2, 2, 3);
histogram(I_high);
title('I\_high', 'FontSize', 8);
xlabel('Intensity', 'FontSize', 7);
ylabel('Frequency', 'FontSize', 7);

subplot(2, 2, 4);
histogram(I_low);
title('I\_low', 'FontSize', 8);
xlabel('Intensity', 'FontSize', 7);
ylabel('Frequency', 'FontSize', 7);
%% 

% subplot(1, 3, 1);
histogram(binaryImage);
title('Binaryimage', 'FontSize', 5);
xlabel('Intensity', 'FontSize', 7);
ylabel('Frequency', 'FontSize', 7);



%% 





% Extract color channels.
redChannel = rgbImage(:,:,1); % Red channel
greenChannel = rgbImage(:,:,2); % Green channel
blueChannel = rgbImage(:,:,3); % Blue channel
% Create an all black channel.
allBlack = zeros(size(redChannel), 'uint8');

% Create color versions of the individual color channels.
just_red = cat(3, redChannel, allBlack, allBlack);
just_green = cat(3, allBlack, greenChannel, allBlack);
just_blue = cat(3, allBlack, allBlack, blueChannel);

% Recombine the individual color channels to create the original RGB image again.
recombinedRGBImage = cat(3, redChannel, greenChannel, blueChannel);

% Display them all.
figure;
subplot(3, 3, 4);
histogram(just_red);
title('Red Channel', 'FontSize', 7)
subplot(3, 3, 5);
histogram(just_green)
title('Green Channel', 'FontSize', 7)
subplot(3, 3, 6);
histogram(just_blue);
title('Blue Channel', 'FontSize', 7)
subplot(3, 3, 8);
histogram(recombinedRGBImage);
title('Histogram RGB Image', 'FontSize', 7)


R_bits = bitshift(redChannel,-5);
G_bits = bitshift(greenChannel,-5);
B_bits = bitshift(blueChannel,-6);

new_8 = bitor(bitor(bitshift(R_bits, 5), bitshift(G_bits, 2)), B_bits);
figure;


% Display histogram of 'new_8'
histogram(new_8);
title('8-bit histogram', 'FontSize', 10);

% Concatenate grayscale image
% Ensure 'new_8' and 'allBlack' are of the same size
com = cat(3, new_8, allBlack, allBlack);

% Display 8 bit image on the red channel
figure;
imshow(com, []);
title(' 8 bit image (red channel)', 'FontSize', 10);

% Display histogram of concatenated image
figure;
histogram(com(:)); % Flatten 'com' for proper histogram display
title('Concatenated image histogram', 'FontSize', 10);



% Compute the histogram of the image
[counts, binEdges] = imhist(grayImage); % 'counts' contains the histogram values

% Compute the cumulative histogram
cumulativeCounts = cumsum(counts);

% Normalize the cumulative histogram to scale between 0 and 1
cumulativeCounts = cumulativeCounts / sum(counts);

% Plot the normalized cumulative histogram
figure;
plot(binEdges, cumulativeCounts, 'LineWidth', 2);
xlabel('Pixel Intensity');
ylabel('Normalized Cumulative Frequency');
title('Normalized Cumulative Histogram');
grid on;


mean  = sum(grayImage)/length(grayImage);
variance = sum((grayImage - mean(grayImage)).^2)/(length(grayImage) - 1);


% Display the grayscale image
imshow(grayImage);
title('Grayscale Image', 'FontSize', 8);

% Overlay text with computed statistics
text(10, 20, sprintf('Mean: %.2f, Variance: %.2f, Median: %.2f', imgMean, imgVariance, imgMedian), ...
    'FontSize', 7, 'Color', 'yellow', 'BackgroundColor', 'black');

title('Concatenated image histogram', 'FontSize', 10);


% Set up figure properties:
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 1, 1]);
% Get rid of tool bar and pulldown menus that are along top of figure.
% set(gcf, 'Toolbar', 'none', 'Menu', 'none');
% Give a name to the title bar.
set(gcf, 'Name', 'Demo by ImageAnalyst', 'NumberTitle', 'Off')





