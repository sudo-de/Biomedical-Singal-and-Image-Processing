Name: Sudip De
Entry Name: 2023MAS7152
Course Number: BML735
%% 4.1. Compare the tumor segmentation results with ground truth masks 
% (Dice coefficient (DC) and Jaccard index (JI)) for the image segmentation algorithms: 
% Ostu thresholding, region growing, K means clustering, Gaussian mixture model and Active contour. 

% Load images and masks
image = dicomread('brain_tumor.dcm');

% Display original image and ground truth mask
figure;
imagesc(image);
title('Original Image');
axis off;
colormap gray;

groundTruthMask = dicomread('brain_tumor_mask.dcm');

% Display ground truth mask
figure;
imagesc(groundTruthMask);
title('Ground Truth Mask');
axis off;
colormap gray;

% Convert images to binary
threshold = graythresh(image);
imageBinary = imbinarize(image, threshold);
groundTruthMask = imbinarize(groundTruthMask);

%% Initialize variables for results
algorithms = {'Ostu thresholding', 'Region growing', 'K-means clustering', 'Gaussian mixture model', 'Active contour'};
DC = zeros(1, length(algorithms));
JI = zeros(1, length(algorithms));

% Ostu thresholding
otsuMask = imageBinary;
[DC(1), JI(1)] = computeMetrics(otsuMask, groundTruthMask);

% Region growing
regionGrowingMask = regionGrowing(image);
[DC(2), JI(2)] = computeMetrics(regionGrowingMask, groundTruthMask);

% K-means clustering
kmeansMask = kmeansClustering(image);
[DC(3), JI(3)] = computeMetrics(kmeansMask, groundTruthMask);

% Gaussian mixture model
gmmMask = gaussianMixtureModel(image);
[DC(4), JI(4)] = computeMetrics(gmmMask, groundTruthMask);

% Active contour
activeContourMask = activeContour(image);
[DC(5), JI(5)] = computeMetrics(activeContourMask, groundTruthMask);

% Display results
disp('Algorithm Comparison Results:');
disp('----------------------------------');
for i = 1:length(algorithms)
    disp([algorithms{i}, ':']);
    disp(['Dice coefficient (DC): ', num2str(DC(i))]);
    disp(['Jaccard index (JI): ', num2str(JI(i))]);
    disp('----------------------------------');
end

%% Function to compute Dice coefficient and Jaccard index
function [DC, JI] = computeMetrics(segmentedMask, groundTruthMask)
    TP = sum(sum(segmentedMask & groundTruthMask));
    FP = sum(sum(segmentedMask & ~groundTruthMask));
    FN = sum(sum(~segmentedMask & groundTruthMask));
    
    DC = 2*TP / (2*TP + FP + FN);
    JI = TP / (TP + FP + FN);
end

%% Implement your segmentation algorithms here

% Region growing
function mask = regionGrowing(image)
    mask = zeros(size(image));
end

% K-means clustering
function mask = kmeansClustering(image)
    mask = zeros(size(image));
end

% Gaussian mixture model
function mask = gaussianMixtureModel(image)
    mask = zeros(size(image));
end

% Active contour
function mask = activeContour(image)
    mask = zeros(size(image));
end

%% 4.2. Compare the segmentation accuracies calculated in Q.1 
% for different algorithms and state which algorithm(s) produced the best/worst segmentation result(s) and why? 
% Which is the best algorithm (you may combine multiple algorithms to create a final algorithm)?

% The best segmentation result:
The best algorithm(s) would be the one(s) with the highest Dice coefficient (DC) and Jaccard index (JI). 
The Gaussian Mixture Model or a combination of algorithms might produce the best result due to its ability to model complex distributions in the data.

% The worst segmentation result:
Otsu thresholding might produce the worst results, especially if the image intensities are not well-separated into foreground and background.

%% 4.3. How to automatically initiate active contour or region growing algorithms without providing seed points or contour by manual selection on any image?

% Active Contour:
You can initialize active contour using edge detection. The edges can serve as a starting point for the active contour algorithm.

% Region Growing:
You can use some heuristic methods like the centroid or the average intensity of the tumor region to automatically initialize the region growing algorithm without manual seed selection.