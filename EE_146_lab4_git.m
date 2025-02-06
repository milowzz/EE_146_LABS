clc;
clear all;
close all;


image = imread('coins.png');


if size(image, 3) == 3
    grayImage = rgb2gray(image);
else
    grayImage = image;
end


% Add Gaussian noise
noisy_gaussian_img = imnoise(grayImage, 'gaussian', 0, 0.01); 

% Add salt and pepper noise 
salt_pepper_img = imnoise(grayImage,'salt & pepper',0.02);

% mean filter (3x3 averaging filter)
h = fspecial('average', [3 3]); % 3x3 mean filter

% gaussian filter
g = fspecial('gaussian', [3 3] , 1);

% median filter 
filtered_img_median_1 = medfilt2(noisy_gaussian_img);
filtered_img_median_2 = medfilt2(salt_pepper_img);


% Apply mean filter
filtered_img_mean_1 = imfilter(noisy_gaussian_img, h, 'replicate');
filtered_img_mean_2 = imfilter(salt_pepper_img, h, 'replicate');

%apply gaussian filter
filtered_img_gaussian_1 = imfilter(noisy_gaussian_img, g, 'replicate');
filtered_img_gaussian_2 = imfilter(salt_pepper_img, g, 'replicate');
% results
figure;

subplot(2,4,1), imshow(noisy_gaussian_img), title('Gaussian Noise img', 'FontSize', 7);
subplot(2,4,2), imshow(filtered_img_mean_1), title('Filtered gaussian Image (Mean Filter)', 'FontSize', 7);
subplot(2,4,3), imshow(filtered_img_median_1), title('Filtered gaussian Image (Median Filter)', 'FontSize', 7);
subplot(2,4,4), imshow(filtered_img_gaussian_1), title('Filtered gaussin_ gaussian img', 'FontSize', 7);
subplot(2,4,6), imshow(filtered_img_mean_2), title('Filtered salt and pepper Image (Mean Filter)', 'FontSize', 7);
subplot(2,4,7), imshow(filtered_img_median_2), title('Filtered salt and pepper Image (Median Filter)', 'FontSize', 7);
subplot(2,4,5), imshow(salt_pepper_img), title('salt and pepper noise img', 'FontSize', 7);
subplot(2,4,8), imshow(filtered_img_gaussian_2), title('Filtered gaussin_ salt&pepper img', 'FontSize', 7);

%edge detectors

%prewitt


prewitt_1 = edge(grayImage, 'Prewitt', 0.01);
prewitt_2 = edge(grayImage, 'Prewitt', 0.03);
prewitt_3 = edge(grayImage, 'Prewitt', 0.05);

%sobel
sobel_1 = edge(grayImage, 'Sobel', 0.01);
sobel_2 = edge(grayImage, 'Sobel', 0.03);
sobel_3 = edge(grayImage, 'Sobel', 0.05);

%LOG
LOG_1 = edge(grayImage, 'Log', 0.01);
LOG_2 = edge(grayImage, 'Log', 0.03);
LOG_3 = edge(grayImage, 'Log', 0.05);

%canny
canny_1 = edge(grayImage, 'Canny', 0.01);
canny_2 = edge(grayImage, 'Canny', 0.03);
canny_3 = edge(grayImage, 'Canny', 0.05);


%convert image to a blurry one

blurred_img = imgaussfilt(grayImage, 2);

shapen_img_1 = imsharpen(blurred_img, Amount = 0.1);
shapen_img_2 = imsharpen(blurred_img, Amount =1.5);
shapen_img_3 = imsharpen(blurred_img, Amount = 0.5);

figure;
subplot(5,3,1), imshow(prewitt_1), title('prewitt (0.01 threshold', 'FontSize', 7);
subplot(5,3,2), imshow(prewitt_2), title('prewitt (0.03 threshold', 'FontSize', 7);
subplot(5,3,3), imshow(prewitt_3), title('prewitt (0.05 threshold', 'FontSize', 7);

subplot(5,3,4), imshow(sobel_1), title('sobel (0.01 threshold', 'FontSize', 7);
subplot(5,3,5), imshow(sobel_2), title('sobel (0.03 threshold', 'FontSize', 7);
subplot(5,3,6), imshow(sobel_3), title('sobel (0.05 threshold', 'FontSize', 7);

subplot(5,3,7), imshow(LOG_1), title('Log (0.01 threshold', 'FontSize', 7);
subplot(5,3,8), imshow(LOG_2), title('Log (0.03 threshold', 'FontSize', 7);
subplot(5,3,9), imshow(LOG_3), title('Log (0.05 threshold', 'FontSize', 7);

subplot(5,3,10), imshow(canny_1), title('canny (0.01 threshold', 'FontSize', 7);
subplot(5,3,11), imshow(canny_2), title('canny (0.03 threshold', 'FontSize', 7);
subplot(5,3,12), imshow(canny_3), title('canny (0.05 threshold', 'FontSize', 7);

subplot(5,3,13), imshow(shapen_img_1), title('Shaprened Image (0.01 threshold', 'FontSize', 7);
subplot(5,3,14), imshow(shapen_img_2), title('Shaprened Image (0.03 threshold', 'FontSize', 7);
subplot(5,3,15), imshow(shapen_img_3), title('Shaprened Image (0.05 threshold', 'FontSize', 7);




